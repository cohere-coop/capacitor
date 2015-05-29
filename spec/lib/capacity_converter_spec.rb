require 'capacity_converter'

describe CapacityConverter do
  include CapacityConverter
  describe "#to_days" do
    Then { expect(to_days(8)).to eql("1 day") }
    Then { expect(to_days(12)).to eql("1 and 1 half days") }
    Then { expect(to_days(2)).to eql("1 quarter day") }
    Then { expect(to_days(1)).to eql("1 eighth day") }
    Then { expect(to_days(3)).to eql("3 eighth days") }
    Then { expect(to_days(9)).to eql("1 and 1 eighth days") }
  end
end
