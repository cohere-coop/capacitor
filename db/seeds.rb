# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

unless Rails.env.production?
  seeds = YAML.load_file(Rails.root.join("db", "seeds.yml"))
  accounts = seeds["accounts"].map do |seed|
    Account.create_with(seed).find_or_create_by(email: seed["email"])
  end
  projects = seeds["projects"].map do |seed|
    Project.create_with(seed).find_or_create_by(name: seed["name"])
  end
  seeds["logs"].map do |seed|
    Log.create!(seed.merge(account: accounts.first, project: projects.first))
  end
end
