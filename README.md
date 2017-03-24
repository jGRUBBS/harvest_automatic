# Notes

```ruby

require 'harvested'
require 'listen'
require 'timers'

# .harvest

{
  directory:  "/Users/justin/Sites/AA",
  project_id: 8299564,
  task_id:    1546164
}

harvest.time.create(hours: 3, project_id: 8299564, task_id: 1546164)


project_directory = "/Users/justin/Sites/"
timers = Timers::Group.new
five_minutes = 300

project_directories = PROJECTS.values.collect { |project| project[:directory] }

listener = Listen.to(project_directory) do |modified, added, removed|
  # check modifed/added/removed directory matches which project
  timer_var_label = "@#{project}_timer"
  timer = instance_variable_get(timer_var_label)
  timer.cancel if timer
  instance_variable_set(timer_var_label, timers.after(five_minutes) { # submit_time_entry })
end
listener.start



module HarvestAutomatic

  module Utility

    def home_directory
      File.expand_path("~/")
    end

  end

  class Configuration
    include Utiltity
    
    def set?
      File.exists?(harvest_config_path)
    end

    def harvest_config_path
      File.join(home_directory, ".harvest-config")
    end
  
  end
end

```