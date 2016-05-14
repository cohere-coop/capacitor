# Decorator for Check Ins
class CheckInDecorator < Draper::Decorator
  HOURS_WORKED = [[nil],
                  ["1 hour or less", 1],
                  ["1~2 hours", 2],
                  ["2~4 hours", 4],
                  ["4~6 hours", 6],
                  ["6~8 hours", 8],
                  ["8~10 hours", 10],
                  ["10~12 hours", 12],
                  ["12~14 hours", 14],
                  ["14+ hours", 16]].freeze

  ATTENTION_LABELS = ["Terrible! I couldn't focus AT ALL",
                      "Bad, I was pretty distracted",
                      "Medicore, I was neither overly focused nor distracted",
                      "Good! I was REALLY focused",
                      "Great! It was Like I was super powered!"].freeze
  ATTENTION_QUALITY = [[nil]] + ATTENTION_LABELS.zip(Journal::ATTENTION_LEVELS)

  delegate_all

  def summary
    "#{worked_at} - #{logs_summary} "
  end

  def amount_options(amount)
    h.options_for_select(HOURS_WORKED, amount)
  end

  def quality_options(quality)
    h.options_for_select(ATTENTION_QUALITY, quality)
  end

  def logs_summary
    logs.map { |log| "#{log.activity.name}: #{log.amount} hours" }.join(" ; ")
  end

  def worked_at
    check_in.worked_at.try { |v| v.to_formatted_s(:friendly_date) }
  end

  def action_text
    if persisted?
      "Edit"
    else
      "Check in"
    end
  end

  def edit_path
    if persisted?
      h.edit_check_in_path(self)
    else
      h.new_check_in_path(check_in: { worked_at: object.worked_at })
    end
  end

  def dom_id
    if persisted?
      "check_in-#{id}"
    else
      "check-in-#{object.worked_at}"
    end
  end
end
