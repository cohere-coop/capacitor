class ProjectDecorator < Draper::Decorator
  delegate_all

  def infinite_capacity?
    if object.capacity == -1
      "Capacity Remaining: Infinite"
    else
      "Capacity Remaining: #{project.capacity_remaining}"
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
