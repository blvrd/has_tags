require "has_tags/version"
require "active_record" 

module HasTags
  require "has_tags/tag"
  require "has_tags/tagging"
  require "has_tags/taggable"
  require "has_tags/tagger"

  ActiveRecord::Base.extend Taggable
  ActiveRecord::Base.extend Tagger
end
