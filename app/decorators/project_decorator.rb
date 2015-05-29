class ProjectDecorator < Draper::Decorator
  delegate_all
  using CapacityConverter

  def capacity_remaining
    if project.capacity == -1
      "Infinity"
    else
      project.capacity_remaining.to_business_days
    end
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
