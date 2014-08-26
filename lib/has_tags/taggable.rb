module HasTags
  module Taggable
    def self.included(base)
      base.class_eval do
        has_many :taggings, as: :taggable, class_name: "HasTags::Tagging"
        has_many :tags, through: :taggings, class_name: "HasTags::Tag"
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
          HasTags::Tagging.where(tag_id: tag.id, taggable_id: self.id, taggable_type: self.class.to_s).first_or_create!
        end
      end
    end

  end
end
