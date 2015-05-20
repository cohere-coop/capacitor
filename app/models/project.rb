class Project < ActiveRecord::Base
  belongs_to :client, class_name: "Account"
  has_many :capacities
  has_many :accounts, through: :capacities

  def calculate_remaining_capacity
    update(capacity_remaining: total_capacity_owed - capacities.pluck(:amount).sum)
  end
end
