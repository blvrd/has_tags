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

    module InstanceMethods
      def save_taggings
        taggings = HasTags::Tagging.where(taggable_type: self.class.to_s, taggable_id: nil)
        puts taggings.map(&:attributes)
        taggings.each do |tagging|
          tagging.taggable_id = self.id
          tagging.save
        end
      end 

      def tag_list
        tags.map(&:name).join(", ")
      end

      def tag_list=(tag_names)
        tag_names.split(",").map do |tag_name|
          names = tag_name.strip.split(":") 
          names.each_with_index do |name, index|
            if index < 1
              tag = HasTags::Tag.where(name: name).first_or_create!
            else
              tag = HasTags::Tag.where(name: name, context_id: Tag.find_by(name: names[index-1]).id).first_or_create!
            end 
            HasTags::Tagging.where(tag_id: tag.id, taggable_type: self.class.to_s).create!
          end
        end
      end

    end
  end
end
