require "active_support/core_ext/string/inflections"

module CapacityConverter
  QUARTER_DAYS_TO_WORDS_MAPPING = [
    { quantity: 4, word: "half" },
    { quantity: 2, word: "quarter" },
    { quantity: 1, word: "eighth" }
  ]
  def to_days(number)
    remainder = number % 8
    total = number / 8
    if total > 0 && remainder == 0
      "#{total} #{pluralized_unit(total)}"
    elsif total > 0 && remainder != 0
      "#{total} and #{partial_day(remainder)}"
    else
      partial_day(remainder)
    end
  end

  def partial_day(remainder)
    QUARTER_DAYS_TO_WORDS_MAPPING.each do |translation|
      result = remainder / translation[:quantity]
      if remainder % translation[:quantity] == 0
        return "#{result} #{translation[:word]} #{pluralized_unit(result)}"
      end
    end
  end

  def pluralized_unit(total, remainder = 0)
    "day".pluralize(total + remainder)
  end
end
