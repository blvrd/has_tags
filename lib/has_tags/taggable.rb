module HasTags
  module Taggable
    # This implementation requires that the taggable module be 
    # used like this: 
    #
    # include HasTags::Taggable
    #
    # in whatever model you wish to have tags.
    #
    #
    # def self.included(base)
    #   base.class_eval do
    #     has_many :taggings, as: :taggable, class_name: "HasTags::Tagging"
    #     has_many :tags, through: :taggings, class_name: "HasTags::Tag"
    #   end
    # end

    def has_tags
      after_save :save_taggings

      has_many :taggings, as: :taggable, class_name: "HasTags::Tagging"
      has_many :tags, through: :taggings, class_name: "HasTags::Tag"

      include InstanceMethods
    end

    def tagged_with(tag_names)
      instances = []
      tag_names.each do |tag_name|
        self.all.each do |instance|
          if instance.tags.where("lower(name) LIKE ?", "%#{tag_name}%").present?
            instances << instance
          end
        end
      end 
      instances
    end

    def top_level_tags
      HasTags::Tag.where(context_id: nil) && HasTags::Tag.all
        .collect{|tag| tag if tag.taggings.where(taggable_type: self.to_s).present? }
    end

    module InstanceMethods
      def save_taggings
        taggings = HasTags::Tagging.where(taggable_type: self.class.to_s, taggable_id: nil) 
        taggings.each do |tagging|
          tagging.taggable_id = self.id
          tagging.save
        end
      end 

      def tag_list
        tags.map(&:name).join(", ")
      end

      def tag_list=(tag_names)
        split_keywords_and_create_tags(tag_names)
      end

      def split_keywords_and_create_tags(tag_names)
        tag_names.split(",").map do |tag_name|
          names = tag_name.strip.split(":")
          names.each_with_index do |name, index|
            if index < 1
              tag = find_or_create_context(name)
            else
              tag = find_or_create_child_tag(name, names, index)
            end 
            create_tagging_for(tag)
          end
        end
      end

      def find_or_create_context(name)
        HasTags::Tag.where(name: name).first_or_create!
      end

      def find_or_create_child_tag(name, collection, index)
        HasTags::Tag.where(name: name, context_id: Tag.find_by(name: collection[index-1]).id).first_or_create!
      end

      def create_tagging_for(tag)
        HasTags::Tagging.where(tag_id: tag.id, taggable_type: self.class.to_s).create!
      end

    end
  end
end
