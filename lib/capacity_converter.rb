require "active_support/core_ext/string/inflections"

module CapacityConverter
  refine Integer do
    QUARTER_DAYS_TO_WORDS_MAPPING = [
      { quantity: 4, word: "half" }.freeze,
      { quantity: 2, word: "quarter" }.freeze,
      { quantity: 1, word: "eighth" }.freeze
    ].freeze

    # @return [String] business days given a number of hours
    def to_business_days
      remainder = abs % 8
      total = abs / 8
      result = if total > 0 && remainder == 0
                 "#{total} #{pluralized_day(total)}"
               elsif total > 0 && remainder != 0
                 "#{total} and #{partial_day(remainder)}"
               else
                 partial_day(remainder)
               end

      self < 0 ? "negative #{result}" : result
    end

    private def partial_day(remainder)
      QUARTER_DAYS_TO_WORDS_MAPPING.each do |translation|
        result = remainder / translation[:quantity]
        if remainder % translation[:quantity] == 0
          return "#{result} #{translation[:word]} #{pluralized_day(result)}"
        end
      end
    end

    private def pluralized_day(total)
      "day".pluralize(total)
    end
  end
end
