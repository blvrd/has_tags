module HasTags
  class Tagging < ::ActiveRecord::Base
    validates :tag_id, presence: true
  end
end
