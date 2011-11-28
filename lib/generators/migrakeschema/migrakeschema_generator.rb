require 'rails/generators'
require 'rails/generators/migration'

class MigrakeschemaGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(dirname)
     if ActiveRecord::Base.timestamped_migrations
       Time.now.utc.strftime("%Y%m%d%H%M%S")
     else
       "%.3d" % (current_migration_number(dirname) + 1)
     end
  end

  def generate_migration
    migration_template "migration_layout.rb.erb","db/migrate/create_migrake_table.rb"
  end

end
