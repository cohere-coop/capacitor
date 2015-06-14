require "capacity_converter"

module ProjectHelper
  using CapacityConverter
  AMOUNT_OPTIONS = [1, 2, 4, 6, 8].map { |i| [i.to_business_days, i] }.unshift(nil)

  WORST = "\xF0\x9F\x98\xA9"
  BAD = "\xF0\x9F\x98\xA5"
  OKAY = "\xF0\x9F\x98\x9E"
  GOOD = "\xF0\x9F\x98\x84"
  BEST = "\xF0\x9F\x98\x86"
  QUALITY_OPTIONS = [nil, WORST, BAD, OKAY, GOOD, BEST]

  def options_for_project_amount
    options_for_select(AMOUNT_OPTIONS)
  end
end
