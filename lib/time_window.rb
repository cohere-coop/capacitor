# frozen_string_literal: true

require "time_of_day"

# A a window of two `TimeOfDay`s.
class TimeWindow
  attr_reader :range

  def initialize(from:, to:)
    from = from.to_time_of_day
    to   = to.to_time_of_day
    raise RangeError if from > to
    self.range = (from..to)
  end

  def to_s
    inspect
  end

  def inspect
    "#{self.class.name}<#{from}..#{to}>"
  end

  def from
    range.begin
  end

  def to
    range.end
  end

  def include?(*args)
    range.include?(*args)
  end

  private

  attr_writer :range
end

# rubocop:disable Style/MethodName
def TimeWindow(from_or_range, to = nil)
  case from_or_range
  when Range
    from = from_or_range.begin
    to   = from_or_range.end
  else
    from   = from_or_range
    to   ||= from
  end
  TimeWindow.new(from: TimeOfDay(from), to: TimeOfDay(to))
end
# rubocop:enable Style/MethodName
