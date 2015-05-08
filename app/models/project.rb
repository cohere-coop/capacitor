class Project < ActiveRecord::Base
  belongs_to :client, class_name: "Account"
	has_many :capacities
	has_many :workers, through: :capacities
end
