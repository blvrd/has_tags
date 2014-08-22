module HasTags
  class Tag < ::ActiveRecord::Base
    validates :name, uniqueness: true, presence: true  
  end
end
