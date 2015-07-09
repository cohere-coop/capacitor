class TeamDecorator < Draper::Decorator
  delegate_all

  def dom_id
    "team-#{team.id}"
  end
end
