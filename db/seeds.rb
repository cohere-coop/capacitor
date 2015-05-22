# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


case Rails.env
when "production"
  if Account.count.zero? && Project.count.zero?
    Account.create!(email: "zee@zincma.de", name: "Zee Spencer", password: ENV["SEED_PASSWORD"])
    Project.create!(name: "Capacitor", capacity: -1)
  else
    Rails.logger.info("Avoiding seeding an already seeded database")
  end
when "development"
  seeds = YAML.load_file(Rails.root.join("db", "seeds.yml"))
  accounts = seeds["account"].map do |seed|
    Account.create!(seed)
  end
  projects = seeds["project"].map do |seed|
    Project.create!(seed)
  end
  seeds["log"].map do |seed|
    Log.create!(seed.merge(account: accounts.first, project: projects.first))
  end
else
  Rails.logger.info("Avoiding seeding in non-important environment")
end
