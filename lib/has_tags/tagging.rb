module HasTags
  class Tagging < ::ActiveRecord::Base
    validates :tag_id, presence: true

    belongs_to :tag
    belongs_to :taggable, polymorphic: true
  end
end
