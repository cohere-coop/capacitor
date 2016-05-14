# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if ENV["IS_STAGING"] || !Rails.env.production?
  [{ name: "Admin", email: "admin@example.com", password: "password" }].each do |user|
    account = Account.create_with(user).find_or_create_by(email: user[:email])
    [{ name: "Capacitor", capacity: -1, weekly_burn_rate: 2, billable: false, active: true },
     { name: "Transistor", capacity: 0, weekly_burn_rate: 0, billable: true, active: true },
     { name: "Voltage", capacity: 25, weekly_burn_rate: 3, billable: true, active: false },
     { name: "Generator", capacity: 40, weekly_burn_rate: 0, billable: true, active: true }].each do |activity|
      activity = account.activities.create_with(activity).find_or_create_by!(name: activity[:name])
      5.times do |x|
        Log.create!(account: account, activity: activity, worked_at: x.days.ago,
                    amount: rand(1..8), quality: rand(1..5))
      end
    end
  end
end
