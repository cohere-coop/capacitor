require "rails_helper"

describe ProjectDecorator do
  using CapacityConverter

  Given(:project) { double(:project, capacity: capacity, capacity_remaining: capacity_remaining) }
  Given(:capacity_remaining) { 8 }
  Given(:decorator) { described_class.new(project) }

  context "capacity is -1" do
    Given(:capacity) { -1 }
    Then { expect(decorator.capacity_remaining).to eql "Infinity" }
  end

  context "capacity is an actual number" do
    Given(:capacity) { 100 }
    Then { expect(decorator.capacity_remaining).to eql capacity_remaining.to_business_days }
  end
end
