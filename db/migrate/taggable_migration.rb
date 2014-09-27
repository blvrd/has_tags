class TaggableMigration < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :context_id
    end

    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, polymorphic: true
      t.references :tagger, polymorphic: true
    end 
  end
end
