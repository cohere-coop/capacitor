# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

seeds = YAML.load_file(Rails.root.join("db", "seeds.yml"))
accounts = Account.create(seeds["account"])
projects = Project.create(seeds["project"])
seeds["log"].map do |seed|
  Log.create(seed.merge(account: accounts.first, project: projects.first))
end
