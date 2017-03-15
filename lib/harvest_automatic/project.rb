module HarvestAutomatic
  class Project

    attr_accessor :directory

    def initialize
      @directory = Dir.pwd
    end

    def setup(force = false)
      return "project is already setup" unless not_setup? || force
      # ask for project id
      # ask for task id
      # write config
    end

    def write_config
      # write project file
    end

    def not_setup?
      # does project file exist?
    end

  end
end
