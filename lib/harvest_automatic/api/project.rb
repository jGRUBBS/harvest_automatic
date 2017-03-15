module HarvestAutomatic
  module API
    module Project

      def list_projects
        HarvestAutomatic.client.projects.all
      end

    end
  end
end
