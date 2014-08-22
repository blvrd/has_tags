module HasTags
  class Tag < ::ActiveRecord::Base
    validates :name, presence: true  
  end
end
