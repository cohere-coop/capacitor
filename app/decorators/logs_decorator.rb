# frozen_string_literal: true

# UI focused methods for groups of log entries
class LogsDecorator < Draper::CollectionDecorator
  RANGE_OF_TIME = (0...4)
  def ranges
    week_ranges + month_ranges
  end

  def week_ranges
    RANGE_OF_TIME.map do |x|
      {
        after_date: x.weeks.ago.beginning_of_week.to_date,
        before_date: x.weeks.ago.end_of_week.to_date,
        label: label_for(x, "week")
      }
    end
  end

  def month_ranges
    RANGE_OF_TIME.map do |x|
      {
        after_date: x.months.ago.beginning_of_month.to_date,
        before_date: x.months.ago.end_of_month.to_date,
        label: label_for(x, "month")
      }
    end
  end

  def label_for(qty, measure)
    return "This #{measure}" if qty.zero?
    return "Last #{measure}" if qty == 1
    "#{qty} #{measure.pluralize(qty)} ago"
  end
end
