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

  ATTENTION_QUALITY = [[nil],
                       ["Bad, I was pretty distracted", 1],
                       ["Medicore, I was neither overly focused nor distracted", 2],
                       ["Good! I was REALLY focused", 3],
                       ["Great! It was Like I was super powered!", 4]].freeze

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end




  delegate_all
  using CapacityConverter

  def summary
    "#{check_in.worked_at}"
  end


end