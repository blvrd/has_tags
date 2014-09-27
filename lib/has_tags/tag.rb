module HasTags
  class Tag < ::ActiveRecord::Base
    #### Self referential association for contexts ####
    belongs_to :context, class_name: "Tag"
    has_many :tags, foreign_key: :context_id
    ###################################################

    has_many :taggings

    validates :name, uniqueness: true, presence: true

    def self.top_level_tags
      where(context_id: nil)
    end
  end
end
