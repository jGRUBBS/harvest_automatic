module HarvestAutomatic
  class Command

    class << self

      def start
        # reads configs
        # starts watcher
      end

      def stop
        # submits latest times
        # stops
      end

      def restart
        stop
        start
      end

      def setup(type)
        case type
        when :user
          # sets up user configs
          HarvestAutomatic.setup
        when :project
          # sets up project config
          HarvestAutomatic.project.setup
        end
      end

      def list_projects
        HarvestAutomatic.client.list_projects
      end

    end

  end
end
