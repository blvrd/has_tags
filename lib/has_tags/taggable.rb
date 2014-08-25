module HasTags
  module Taggable
    def self.included(base)
      base.class_eval do
        has_many :taggings, as: :taggable, class_name: "HasTags::Tagging"
        has_many :tags, through: :taggings, class_name: "HasTags::Tag"
      end
    end
  end
end
