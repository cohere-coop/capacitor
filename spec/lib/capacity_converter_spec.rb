require "capacity_converter"

describe CapacityConverter do
  using described_class
  describe "#to_days" do
    Then { expect(8.to_days).to eql("1 day") }
    Then { expect(12.to_days).to eql("1 and 1 half day") }
    Then { expect(2.to_days).to eql("1 quarter day") }
    Then { expect(1.to_days).to eql("1 eighth day") }
    Then { expect(3.to_days).to eql("3 eighth days") }
    Then { expect(9.to_days).to eql("1 and 1 eighth day") }
  end
end
