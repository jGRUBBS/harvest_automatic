require 'spec_helper'

describe HarvestAutomatic::Configuration do

  let(:config) { HarvestAutomatic::Configuration.new }

  describe "parse" do
    let(:expected_hash) do
      {
        subdomain: "testsubdomain",
        username:  "testuser",
        password:  "testpassword"
      }
    end

    before do
      allow(config).to receive(:path) do
        File.expand_path("../../examples/.harvest-config", __FILE__)
      end
    end

    it "reads configuration info from the user's .harvest-config file" do
      expect(config.user_info).to eq(expected_hash)
    end
  end

end
