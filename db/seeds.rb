# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if ENV["IS_STAGING"] || !Rails.env.production?
  [{ name: "Admin", email: "admin@example.com", password: "password" },
   { name: "Team Leader", email: "team-leader@example.com", password: "password" },
   { name: "Team Member", email: "team-member@example.com", password: "password" }].each do |user|
    Account.create_with(user).find_or_create_by(email: user[:email])
  end

  admin = Account.find_by(email: "admin@example.com")
  [{ name: "Capacitor", capacity: -1, weekly_burn_rate: 2, billable: false,
     active: true, owner: admin },
   { name: "Transistor", capacity: 0, weekly_burn_rate: 0, billable: true,
     active: true, owner: admin },
   { name: "Voltage", capacity: 25, weekly_burn_rate: 3, billable: true,
     active: false, owner: admin },
   { name: "Generator", capacity: 40, weekly_burn_rate: 0, billable: true,
     active: true, owner: admin }].each do |activity|
    Activity.create_with(activity).find_or_create_by!(name: activity[:name])
  end

  [{ name: "Team Awesome", activities: ["Capacitor"],
     members: { "team-leader@example.com" => :leader,
                "team-member@example.com" => :member } }].each do |team_definition|
    team = Team.find_or_create_by(name: team_definition[:name])
    Activity.where(name: team_definition[:activities]).each do |activity|
      team.teams_activities.find_or_create_by!(activity: activity)
    end
    Account.where(email: team_definition[:members].keys).each do |member|
      member.enable_feature(:has_teams)
      team.memberships.create_with(level: team_definition[:members][member.email])
          .find_or_create_by(account: member)
    end
  end
end
