require "active_support/core_ext/string/inflections"

module CapacityConverter
  refine Numeric do
    # @return [String] business days given a number of hours
    def to_business_days
      BusinessDayCalculator.new(self).to_s
    end
  end

  class BusinessDayCalculator
    FULL_DAY = 8.0

    def initialize(amount)
      @value = amount / FULL_DAY
    end

    def to_s
      if some?
        some
      else
        none
      end
    end

    def some?
      !@value.zero?
    end
    private :some?

    def some
      "#{@value.to_s.gsub(/\A0|\.0\z/, "")} #{pluralized}"
    end
    private :some

    def none
      "zero days"
    end
    private :none

    def pluralized
      "day".pluralize(@value)
    end
    private :pluralized
  end
end
