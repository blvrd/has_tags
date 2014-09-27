require 'rails/generators/active_record'

module HasTags
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path("../../../../db/migrate", __FILE__)

    def create_migrations
      migration_template "taggable_migration.rb", "db/migrate/taggable_migration.rb"
    end

    def self.next_migration_number(path)
      @migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i.to_s
    end
  end
end
