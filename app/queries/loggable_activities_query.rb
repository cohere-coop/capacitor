# frozen_string_literal: true

# Loads all activites a given account may log time against
class LoggableActivitiesQuery
  def initialize(account:)
    @account = account
  end

  def records
    Activity.where(owner: account).or(Activity.where(id: teams_activities_ids))
  end

  private

  attr_reader :account

  def teams_activities_ids
    account.teams.includes(:teams_activities).pluck(:activity_id)
  end
end
