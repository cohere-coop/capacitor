require "rails_helper"

RSpec.describe ActivityDecorator, type: :decorator do
  using CapacityConverter

  Given(:activity) do
    instance_double(Activity, capacity: capacity,
                              capacity_remaining: capacity_remaining,
                              quality_by_week: { "2015-05-20" => 3 })
  end
  Given(:capacity_remaining) { 8 }
  Given(:decorator) { described_class.new(activity) }
  Given(:capacity) { 5 }

  context "capacity is -1" do
    Given(:capacity) { -1 }
    Then { expect(decorator.capacity_remaining).to eql "Infinity" }
  end

  context "capacity is an actual number" do
    Given(:capacity) { 100 }
    Then { expect(decorator.capacity_remaining).to eql capacity_remaining.to_business_days }
  end

  describe "#quality_by_week" do
    it "translates the quality into smiley faces" do
      expect(decorator.quality_by_week).to eql(["😐"])
    end
  end
end
