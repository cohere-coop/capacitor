class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"

  has_many :teams_projects
  has_many :projects, through: :teams_projects

  has_many :memberships
  has_many :accounts, through: :memberships

  validates :leader, presence: true
  validates :name, presence: true, uniqueness: true
end
