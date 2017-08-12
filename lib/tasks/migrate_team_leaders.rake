# frozen_string_literal: true

namespace :capacitor do
  desc "Migrate leader from teams to membership table"
  task move_leaders_to_memberships: :environment do
    Team.all.each do |team|
      team.add_leader(team.leader)
    end
  end
end
