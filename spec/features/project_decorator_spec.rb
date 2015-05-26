require "rails_helper"

describe ProjectDecorator do
  let(:project) { instance_double(Project) }
  #  Rubocop error: Spec/DescribedClass: Use described_class instead of ProjectDecorator
  # let(:decorator) { ProjectDecorator.new(project) }
  let(:decorator) { described_class.new(project) }

  before do
    allow(project).to receive(:id).and_return(1)
  end

  describe "#infinite_capacity?" do
    let(:infinite_capacity) { decorator.capacity_remaining }

    context "when capacity is -1" do
      let(:project) { instance_double(Project, capacity: -1) }
      it "returns infinite capacity when capacity is -1" do
        expect(infinite_capacity).to eq("Capacity Remaining: Infinite")
      end
    end

    context "when capacity is > 0" do
      let(:project) { FactoryGirl.create(:project) }
      it "returns the remaining value of capacity left" do
        # allow(project).to receive(:capacity_remaining).and_return(capacity - capacity_logged)
        expect(infinite_capacity).to eq(project.capacity_remaining)
      end
    end
  end
end
