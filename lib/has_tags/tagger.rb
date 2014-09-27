module HasTags
  module Tagger
    def is_tagger
      has_many :taggings, as: :tagger, class_name: "HasTags::Tagging"
      has_many :tags, through: :taggings, class_name: "HasTags::Tag"

      include InstanceMethods
    end

    module InstanceMethods
    end
  end
end
