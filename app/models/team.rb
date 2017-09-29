# frozen_string_literal: true

# Groups of Accounts.
class Team < ActiveRecord::Base
  has_many :teams_activities
  has_many :activities, through: :teams_activities

  has_many :memberships
  has_many :members, through: :memberships, source: :account, class_name: "Account"
  has_many :leaders, -> { where(memberships: { level: "leader" }) },
           through: :memberships, source: :account, class_name: "Account"

  validates :name, presence: true

  def add_leader(account)
    memberships.find_or_create_by(account: account).make_leader
  end

  def add_member(account)
    memberships.find_or_create_by(account: account)
  end
end
