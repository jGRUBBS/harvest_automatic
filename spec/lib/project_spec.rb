require 'spec_helper'

describe HarvestAutomatic::Project do

  let(:project) { HarvestAutomatic::Project.new }

  before do
    allow(project).to receive(:path) do
      File.expand_path("../../examples/.harvest", __FILE__)
    end
  end

  describe '#info' do
    let(:expected_hash) do
      {
        project_path: "/Users/developer/Projects/project",
        project_id:   "123456",
        task_id:      "789101"
      }
    end

    it "reads project info from the project's .harvest file" do
      expect(project.info).to eq(expected_hash)
    end
  end

  describe '#setup' do
    after { project.setup }
    context '.harvest file already exists' do
      it 'prints a message informing that the file already exists' do
        expect(STDOUT).to receive(:puts).with("Havest project already setup\nTo reconfigure project`harvest project -f`")
      end
    end
    context '.harvest file does not exist' do
      before do
        allow(project).to receive(:path) do
          File.expand_path("../../examples/.harvest-test", __FILE__)
        end
      end
      let(:success_msg) { ".harvest written in project directory successfully" }
      it 'calls #run_setup and prints a success message' do
        expect(STDOUT).to receive(:puts).with(success_msg)
        expect(project).to receive(:run_setup)
      end
    end
  end

end
