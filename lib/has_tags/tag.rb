module HasTags
  class Tag < ::ActiveRecord::Base
    #### Self referential association for contexts ####
    belongs_to :context, class_name: "Tag"
    has_many :tags, foreign_key: :context_id
    ###################################################

    has_many :taggings

    validates :name, uniqueness: true, presence: true  

  end
end
