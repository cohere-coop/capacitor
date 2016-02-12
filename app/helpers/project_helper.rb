require "capacity_converter"

module ProjectHelper
  using CapacityConverter
  AMOUNT_OPTIONS = [1, 2, 4, 6, 8].map { |i| [i.to_business_days, i] }.unshift(nil)

  WORST = "😡".freeze
  BAD = "😟".freeze
  OKAY = "😐".freeze
  GOOD = "😌".freeze
  BEST = "😄".freeze
  QUALITY_OPTIONS = [[nil], [WORST, 1], [BAD, 2], [OKAY, 3], [GOOD, 4], [BEST, 5]].freeze

  def options_for_project_amount
    options_for_select(AMOUNT_OPTIONS)
  end
end
