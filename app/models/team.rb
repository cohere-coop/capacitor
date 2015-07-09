class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"

  has_many :teams_projects
  has_many :projects, through: :teams_projects

  validates :leader, presence: true
  validates :name, presence: true, uniqueness: { scope: :leader_id }
end
