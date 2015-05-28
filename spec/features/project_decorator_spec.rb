require "rails_helper"

describe ProjectDecorator do
  let(:project) { instance_double(Project) }
  let(:decorator) { described_class.new(project) }

  before do
    allow(project).to receive(:id).and_return(1)
  end

  describe "#capacity_remaining" do
    let(:infinite_capacity) { decorator.capacity_remaining }

    context "when capacity is -1" do
      let(:project) { instance_double(Project, capacity: -1) }
      it "returns infinite capacity when capacity is -1" do
        expect(infinite_capacity).to eq("Infinity")
      end
    end

    context "when capacity is > 0" do
      let(:project) { FactoryGirl.create(:project) }
      it "returns the remaining value of capacity left" do
        expect(infinite_capacity).to eq(project.capacity_remaining)
      end
    end
  end
end
