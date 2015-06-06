require "rails_helper"

RSpec.describe ProjectDecorator, type: :decorator do
  using CapacityConverter

  let(:_capacity_remaining) do
    8
  end

  let(:project) do
    instance_double(Project)
  end

  let(:decorator) do
    described_class.new(project)
  end

  before(:each) do
    allow(project).to receive(:capacity_remaining).and_return(_capacity_remaining)
  end

  describe "#capacity_remaining" do
    let(:capacity_remaining) do
      decorator.capacity_remaining
    end

    it "returns the amount in days" do
      expect(capacity_remaining).to eql("1 day of work remaining")
    end

    context "when project capacity remaining is infinty" do
      let(:_capacity_remaining) do
        Float::INFINITY
      end

      it "returns the phrase 'infinite work remaining'" do
        expect(capacity_remaining).to eq("infinite work remaining")
      end
    end

    context "when project capacity remaining is 0" do
      let(:_capacity_remaining) do
        0
      end

      it "returns the phrase '0 half days of work remaining'" do
        expect(capacity_remaining).to eq("zero days of work remaining")
      end
    end
  end
end
