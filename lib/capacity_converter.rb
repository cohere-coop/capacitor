require 'active_support/core_ext/string/inflections'

module CapacityConverter
  def to_days(number)
    remainder = number % 8
    total = number / 8
    if total > 0
      if (remainder == 0)
        "#{total} #{"day".pluralize(total)}"
      elsif remainder % 4 == 0
        "#{total} and #{remainder / 4} half #{pluralized_unit(total, remainder)}"
      elsif remainder % 2 == 0
        "#{total} and #{remainder / 2} quarter #{pluralized_unit(total, remainder)}"
      else
        "#{total} and #{remainder} eighth #{pluralized_unit(total, remainder)}"
      end
    else
      if remainder % 4 == 0
        "#{remainder / 4} half #{pluralized_unit(remainder / 4)}"
      elsif remainder % 2 == 0
        "#{remainder / 2} quarter #{pluralized_unit(remainder / 2)}"
      else
        "#{remainder} eighth #{pluralized_unit(remainder)}"
      end
    end
  end


  def pluralized_unit(total, remainder=0)
    "day".pluralize(total + remainder)
  end
end
