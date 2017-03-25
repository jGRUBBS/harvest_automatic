require 'spec_helper'

describe HarvestAutomatic::Configuration do

  let(:config) { HarvestAutomatic::Configuration.new }

  before do
    allow(config).to receive(:path) do
      File.expand_path("../../examples/.harvest-config", __FILE__)
    end
  end

  describe '#user_info' do
    let(:expected_hash) do
      {
        project_path: "/Users/developer/Projects",
        subdomain:    "testsubdomain",
        username:     "testuser",
        password:     "testpassword"
      }
    end

    it "reads configuration info from the user's .harvest-config file" do
      expect(config.user_info).to eq(expected_hash)
    end
  end

  describe '#project_path' do
    it 'reads the project path from user info' do
      expect(config.project_path).to eq('/Users/developer/Projects')
    end
  end

  describe '#subdomain' do
    it 'reads the subdomain from user info' do
      expect(config.subdomain).to eq('testsubdomain')
    end
  end

  describe '#username' do
    it 'reads the username from user info' do
      expect(config.username).to eq('testuser')
    end
  end

  describe '#password' do
    it 'reads the password from user info' do
      expect(config.password).to eq('testpassword')
    end
  end

  describe '#setup' do
    after { config.setup }
    context '.harvest file already exists' do
      it 'prints a message informing that the file already exists' do
        expect(STDOUT).to receive(:puts).with("Havest configuration already exists\nTo reset configuration use `harvest setup -f`")
      end
    end
    context '.harvest file does not exist' do
      before do
        allow(config).to receive(:path) do
          File.expand_path("../../examples/.harvest-config-test", __FILE__)
        end
      end
      let(:success_msg) { ".harvest-config written in your user directory successfully" }
      it 'calls #run_setup and prints a success message' do
        expect(STDOUT).to receive(:puts).with(success_msg)
        expect(config).to receive(:run_setup)
      end
    end
  end

end
