class TaggableModel < ActiveRecord::Base
  include HasTags::Taggable
end
