require "capacity_converter"

# UI-centered helper methods for Activity related forms
module ActivityHelper
  using CapacityConverter

  AMOUNT_OPTIONS = [1, 2, 4, 6, 8].map { |i| [i.to_business_days, i] }.unshift(nil)
  QUALITY_OPTIONS = [[nil], ["😡", 1], ["😟", 2], ["😐", 3], ["😌", 4], ["😄", 5]].freeze
end
