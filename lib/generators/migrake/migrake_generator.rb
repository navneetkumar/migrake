class MigrakeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_rake_layout
      empty_directory "lib/tasks/migrake"
     template "task_layout.rake.erb","lib/tasks/migrake/#{timestamp}_#{escaped_file_name}.rake"
  end

  private

  def timestamp
    Time.now.strftime("%Y%m%d%H%M%S")
  end

  def task_name
    file_name
  end

  def escaped_file_name
    file_name.underscore
  end

end
