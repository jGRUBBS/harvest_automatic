require "harvest_automatic/api"
require "harvest_automatic/core_ext/hash"
require "harvest_automatic/command"
require "harvest_automatic/version"
require "harvest_automatic/utility"
require "harvest_automatic/configuration"
require "harvest_automatic/client"

module HarvestAutomatic

  def self.config
    @config ||= Configuration.new
  end

  def self.user_info
    config.user_info
  end

  def self.client
    @client ||= Client.new
  end

  def self.project_id
    @project_id
  end

  def self.project_id=(id)
    @project_id = id
  end

  def self.task_id
    @task_id
  end

  def self.task_id=(id)
    @task_id = id
  end

  def self.setup
    config.setup
  end

  def self.project
    Project.new
  end

end
