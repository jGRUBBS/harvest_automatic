require 'json'
require 'highline/import'
module HarvestAutomatic
  class Configuration
    include Utility

    def user_info
      @user_info ||= JSON.parse(file).symbolize_keys
    end

    def project_path
      user_info[:project_path]
    end

    def subdomain
      user_info[:subdomain]
    end

    def username
      user_info[:username]
    end

    def password
      user_info[:password]
    end

    def setup
      # TODO: add -f [FORCE] option
      if File.exists?(path)
        message  = "Havest configuration already exists\n"
        message += "To reset configuration use `harvest setup -f`"
        puts message
      else
        run_setup
        puts ".harvest-config written in your user directory successfully"
      end
    end

    private

    def run_setup
      project_path = ask "What is the parent directory of all your projects? "
      subdomain    = ask "What is your harvestapp.com subdomain? "
      email        = ask "What is your harvestapp.com email? "
      password     = ask "Enter Your Password: "
      write_config_file(project_path, subdomain, email, password)
    end

    def write_config_file(project_path, subdomain, email, password)
      File.open(path, 'w') { |f| f.write(convert_template(project_path, subdomain, email, password)) }
    end

    def convert_template(project_path, subdomain, email, password)
      template = File.read(template_file)
      template.sub!("PROJECT_PATH", project_path)
      template.sub!("SUBDOMAIN",    subdomain)
      template.sub!("USERNAME",     email)
      template.sub!("PASSWORD",     password)
      template
    end

    def template_file
      File.expand_path("../templates/.harvest-config.tpl", __FILE__)
    end

    def file
      File.read(path)
    end

    def path
      File.join(home_directory, ".harvest-config")
    end

  end
end
