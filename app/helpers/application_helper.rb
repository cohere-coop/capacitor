module ApplicationHelper
  def link_to_new_log_entry(project)
    link_to "", new_project_log_path(project), id: "#{project.id}_new_log_entry"
  end

  def can_view?(team)
    can_manage?(team) || current_account.teams.include?(team)
  end
end
