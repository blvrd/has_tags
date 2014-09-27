require 'has_tags'
require 'support/database_cleaner'
require 'support/taggable_model'
require 'support/user'
require 'database_cleaner'
require 'shoulda/matchers'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", 
                                       :database => ":memory:")

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :tags, force: true do |t|
    t.string :name
    t.integer :context_id
  end

  create_table :taggings, force: true do |t|
    t.references :tag
    t.references :taggable, polymorphic: true
    t.references :tagger, polymorphic: true
  end

  create_table :taggable_models, force: true do |t|
    t.string :name
  end

  create_table :users, force: true do |t|
    t.string :username
  end
end

