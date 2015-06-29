class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"

  has_many :teams_projects
  has_many :projects, through: :teams_projects

  validates :name, presence: true
  validates :leader, presence: true
end
