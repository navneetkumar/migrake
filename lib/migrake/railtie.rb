require 'migrake'
require 'rails'
module Migrake
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/migrake.rake'
    end

  end
end

