require "harvest_automatic/api"
require "harvest_automatic/core_ext/hash"
require "harvest_automatic/project"
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
    @client ||= Client.client
  end

  def self.setup
    config.setup
  end

  def self.project(*args)
    project = Project.new
    case args[0]
    when 'setup'
      project.setup
    when 'info'
      project.info.each do |k, v|
        puts "#{k.to_s.ljust(15)} #{v}"
      end
    end
  end

end
