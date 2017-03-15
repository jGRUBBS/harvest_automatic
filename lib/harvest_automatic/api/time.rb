module HarvestAutomatic
  module API
    module Time

      def create_time_entry(hours)
        HarvestAutomatic.client.time.create(
          hours:      hours,
          project_id: HarvestAutomatic.project_id,
          task_id:    HarvestAutomatic.task_id
        )
      end

    end
  end
end
