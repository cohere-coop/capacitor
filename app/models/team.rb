class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"

  has_many :teams_projects
  has_many :projects, through: :teams_projects

  has_many :memberships
  has_many :accounts, through: :memberships

  validates :name, presence: true, uniqueness: { scope: :leader_id }

  def add_leader(account)
    memberships.find_or_create_by(account: account).make_leader
  end
end
