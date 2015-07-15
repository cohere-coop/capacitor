class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"

  has_many :teams_projects
  has_many :projects, through: :teams_projects

  has_many :memberships
  has_many :accounts, through: :memberships
  has_many :leaders, -> { where(memberships: { level: "leader" }) },
           through: :memberships, source: :account, class_name: "Account"

  validates :name, presence: true, uniqueness: { scope: :leader_id }

  def add_leader(account)
    memberships.find_or_create_by(account: account).make_leader
  end

  def add_member(account)
    memberships.find_or_create_by(account: account)
  end
end
