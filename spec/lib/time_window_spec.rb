require "rails_helper"
require "time_window"

RSpec.describe TimeWindow do
  describe "a normal span between 9AM and noon" do
    subject(:range) { TimeWindow("9:00AM", "12:00PM") }

    it { is_expected.to include(TimeOfDay("9:00AM")) }
    it { is_expected.to include(TimeOfDay("10:00AM")) }
    it { is_expected.to include(TimeOfDay("12:00PM")) }
    it { is_expected.not_to include(TimeOfDay("8:00AM")) }
    it { is_expected.not_to include(TimeOfDay("1:00PM")) }
  end

  describe "a one-hour span at at 9AM" do
    subject(:range) { TimeWindow("9:00AM", "9:00AM") }

    it { is_expected.to include(TimeOfDay("9:00AM")) }
    it { is_expected.not_to include(TimeOfDay("8:00AM")) }
    it { is_expected.not_to include(TimeOfDay("10:00AM")) }
  end

  describe "a midnight to 11PM range" do
    subject(:range) { TimeWindow("12:00AM", "11:00PM") }

    it { is_expected.to include(TimeOfDay("12:00AM")) }
    it { is_expected.to include(TimeOfDay("11:00PM")) }
    it { is_expected.to include(TimeOfDay("12:00PM")) }
  end

  describe "invalid ranges" do
    it "disallows backwards ranges" do
      expect { TimeWindow("1:00PM", "12:00PM") }.to raise_error(RangeError)
    end

    it "disallows multi-hour windows ending in 12AM" do
      expect { TimeWindow("12:00AM", "12:00AM") }.to_not raise_error
      expect { TimeWindow("11:00PM", "12:00AM") }.to raise_error(RangeError)
    end
  end

  describe "constructor function" do
    it "has a shorthand for single-hour ranges" do
      window = TimeWindow("9:00AM")
      expect(window.from).to eq(TimeOfDay("9:00AM"))
      expect(window.to).to eq(TimeOfDay("9:00AM"))
    end

    it "can consume ranges" do
      window = TimeWindow("9:00AM".."11:00AM")
      expect(window.from).to eq(TimeOfDay("9:00AM"))
      expect(window.to).to eq(TimeOfDay("11:00AM"))      
    end
  end
end
