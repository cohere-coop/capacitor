# frozen_string_literal: true

require "capacity_converter"

# UI-centered helper methods for Activity related forms
module ActivityHelper
  using CapacityConverter
  QUALITY_OPTIONS = [[nil]] + ["😡", "😟", "😐", "😌", "😄"].zip(Journal::ATTENTION_LEVELS)
  AMOUNT_OPTIONS = [1, 2, 4, 6, 8].map { |i| [i.to_business_days, i] }.unshift(nil)
end
