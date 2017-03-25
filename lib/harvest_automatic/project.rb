module HarvestAutomatic
  class Project

    attr_accessor :directory

    def initialize
      @directory = Dir.pwd
    end

    def info
      @info ||= JSON.parse(file).symbolize_keys
    end

    def setup(force = false)
      if File.exists?(path)
        message  = "Havest project already setup\n"
        message += "To reconfigure project`harvest project -f`"
        puts message
      else
        run_setup
        puts ".harvest written in project directory successfully"
      end
    end

    private

    def run_setup
      project_id = ask "What is your project ID? "
      task_id    = ask "What is your project task ID "
      write_config_file(project_id, task_id)
    end

    def write_config_file(project_id, task_id)
      File.open(path, 'w') do |f|
        f.write(convert_template(project_id, task_id))
      end
    end

    def convert_template(project_id, task_id)
      template = File.read(template_file)
      template.sub!("PROJECT_PATH", directory)
      template.sub!("PROJECT_ID",   project_id)
      template.sub!("TASK_ID",      task_id)
      template
    end

    def template_file
      File.expand_path("../templates/.harvest.tpl", __FILE__)
    end

    def file
      File.read(path)
    end

    def path
      File.join(directory, ".harvest")
    end

  end
end
