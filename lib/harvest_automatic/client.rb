require 'harvested'
module HarvestAutomatic
  class Client
    include HarvestAutomatic::API::Time
    include HarvestAutomatic::API::Project

    def self.client
      @client ||= Harvest.hardy_client(
        subdomain: HarvestAutomatic.config.subdomain,
        username:  HarvestAutomatic.config.username,
        password:  HarvestAutomatic.config.password
      )
    end

  end
end
