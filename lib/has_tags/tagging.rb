module HasTags
  class Tagging < ::ActiveRecord::Base
    validates :tag_id, presence: true

    belongs_to :tag
    belongs_to :taggable, polymorphic: true
    belongs_to :tagger, polymorphic: true
  end
end
