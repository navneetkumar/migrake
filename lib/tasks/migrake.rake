namespace :migrake do

  desc "Run all pending automated rake"
  task :run => :environment do
    get_all.each do |task|
      remove_prereq task
      unless RakeTask.exists? :task_name => task.name
        task.invoke
        RakeTask.add_task task
      end
    end
    puts "All pending task ran successfully."
  end

  desc "List pending automated rake"
  task :pending => :environment do
    existing_tasks = RakeTask.all.map(&:task_name)
    get_all.each do |task|
      puts task.name unless existing_tasks.include? task.name
    end
  end
  
  desc "Generate a automated rake task"
  task :generate,:task_name do |t,args|
      return if args.empty?
     puts "#{args.task_name}"
  end

  desc "List All the automated rake"
  task :list => :environment do
    puts "\n\n"
    get_all.each do  |task|
      taskobj = RakeTask.find_by_task_name task.name
      invoked_at = "pending"
      invoked_at = taskobj.invoked_at.to_s if taskobj
      puts "#{task.name}--------#{invoked_at}"
    end
  end

  desc "Prepares gem for usage"
  task :install => :environment do
    system("rails g migrakeschema")
    Rake::Task['db:migrate'].invoke
  end

  private
  
  KEY = 'migrake'

  def get_all
    tasks = Rake.application.tasks.select { |t| auto_prerequisite(t).present? }
    task_map = tasks.group_by{ |task| auto_prerequisite(task) != KEY }
    task_map[true].sort_by{ |task| auto_prerequisite(task) } + task_map[false]

  end

  def remove_prereq task
    task.prerequisites.delete_if {|t| t =~ /#{KEY}/}
    task
  end

  def auto_prerequisite task
    task.prerequisites.select { |x| x =~/^#{KEY}(_\d+)?$/ }.try(:first)
  end

end

class RakeTask < ActiveRecord::Base
  class << self
    def add_task task
      self.create :task_name => task.name, :invoked_at => Time.now
    end
  end
end
