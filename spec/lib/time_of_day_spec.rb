# frozen_string_literal: true

require "time_of_day"
require "rails_helper"

RSpec.describe TimeOfDay do
  it "can be instantiated from a string representation" do
    value = described_class.from_string("3:00AM")
    expect(value.as_string).to eq("3:00AM")
  end

  it "can be instantiated from an hour of the day" do
    value = described_class.from_hour_of_day(3)
    expect(value.as_string).to eq("3:00AM")
  end

  it "can be instantiated from a Time representation" do
    value = described_class.from_time(Chronic.parse("3:00AM"))
    expect(value.as_string).to eq("3:00AM")
  end

  it "can be converted into a a time of day" do
    value = described_class.from_string("3:00AM")
    converted_value = value.to_time_of_day

    expect(converted_value).to be(value)
  end

  it "blows up when given hours that are not hours of the day" do
    expect { described_class.from_hour_of_day(-1) }.to raise_error(RangeError)
    expect { described_class.from_hour_of_day(24) }.to raise_error(RangeError)
    expect { described_class.from_hour_of_day(nil) }.to raise_error(TypeError)
    expect { described_class.from_hour_of_day("zebras") }.to raise_error(ArgumentError)
    expect { described_class.from_hour_of_day("11zebras") }.to raise_error(ArgumentError)
  end

  it "derives hour_of_day number from its value" do
    value = described_class.from_string("3:00AM")
    expect(value.hour_of_day).to eq(3)
  end

  it "handles PM times correctly" do
    value = described_class.from_string("3:00PM")
    expect(value.hour_of_day).to eq(15)
  end

  it "blows up if not given a parseable time string" do
    expect { described_class.from_string("zebras") }.to raise_error(ArgumentError)
  end

  it "equals another TimeOfDay with the same hour_of_day value" do
    time1 = described_class.from_hour_of_day(3)
    time2 = described_class.from_hour_of_day(3)

    expect(time1).to eq(time2)
  end

  it "can provide a list of acceptable values" do
    expect(TimeOfDay.acceptable_values).to include(TimeOfDay.from_hour_of_day(0))
    expect(TimeOfDay.acceptable_values).to include(TimeOfDay.from_hour_of_day(3))
    expect(TimeOfDay.acceptable_values).to include(TimeOfDay.from_hour_of_day(14))
    expect(TimeOfDay.acceptable_values).to include(TimeOfDay.from_hour_of_day(23))

    expect(TimeOfDay.acceptable_values.length).to eq(24)
    expect(TimeOfDay.acceptable_values).to match_array(TimeOfDay.acceptable_values.uniq)
  end

  it "provides a human-readable string to to_s" do
    expect(TimeOfDay.from_hour_of_day(3).to_s).to eq("3:00AM")
  end

  describe "Range compatibility" do
    it "knows its successor" do
      expect(TimeOfDay("9:00AM").succ).to eq(TimeOfDay("10:00AM"))
      expect(TimeOfDay("11:00AM").succ).to eq(TimeOfDay("12:00PM"))
      expect(TimeOfDay("12:00AM").succ).to eq(TimeOfDay("1:00AM"))
    end

    it "is comparable" do
      expect(TimeOfDay("9:00AM")).to be < TimeOfDay("10:00AM")
      expect(TimeOfDay("12:00PM")).to be > TimeOfDay("11:00AM")
      expect(TimeOfDay("12:00AM") <=> TimeOfDay("1:00AM")).to eq(-1)
    end
  end

end
