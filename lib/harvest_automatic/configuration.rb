require 'json'
require 'highline/import'
module HarvestAutomatic
  class Configuration
    include Utility

    def subdomain
      info[:subdomain]
    end

    def username
      info[:username]
    end

    def password
      info[:password]
    end

    def user_info
      @user_info ||= JSON.parse(file).symbolize_keys
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
      subdomain = ask "harvest subdomain: "
      email     = ask "harvest email: "
      password  = ask "harvest password: "
      write_config_file(subdomain, email, password)
    end

    def write_config_file(subdomain, email, password)
      File.open(path, 'w') { |f| f.write(convert_template(subdomain, email, password)) }
    end

    def convert_template(subdomain, email, password)
      template = File.read(template_file)
      template.sub!("SUBDOMAIN", subdomain)
      template.sub!("USERNAME",  email)
      template.sub!("PASSWORD",  password)
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
