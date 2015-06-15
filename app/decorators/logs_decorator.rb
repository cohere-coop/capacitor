class LogsDecorator < Draper::CollectionDecorator
  def ranges
    [0, 1,2,3,4].map do |x|
      {
        after_date: x.weeks.ago.beginning_of_week.to_date,
        before_date: x.weeks.ago.end_of_week.to_date,
        label: label_for(x, "week")
      }
    end + [0,1,2,3].map do |x|
      {
        after_date: x.months.ago.beginning_of_month.to_date,
        before_date: x.months.ago.end_of_month.to_date,
        label: label_for(x, "month")
      }
    end
  end

  def label_for(qty, measure)
    return "This #{measure}" if qty == 0
    return "Last #{measure}" if qty == 1
    "#{qty} #{measure.pluralize(qty)} ago"
  end
end
