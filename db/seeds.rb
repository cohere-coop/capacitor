# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



client = Account.create_with(password: "password", name: "Client", username: "client").find_or_create_by(email: "client@example.com")
worker = Account.create_with(password: "password", name: "Worker", username: "worker").find_or_create_by(email: "worker@example.com")



arpa = client.owned_projects.find_or_create_by(name: "ARPANet")