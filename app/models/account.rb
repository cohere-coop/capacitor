class Account < ActiveRecord::Base
  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :trackable
  devise :validatable

  has_many :logs
  has_many :projects, through: :logs

  has_many :memberships
  has_many :teams, through: :memberships
  has_many :owned_teams, -> { where(memberships: { level: "leader" }) },
           through: :memberships, source: :team, class_name: "Team"

  validates :name, presence: true

  def total_recent_capacity
    logs.recent.pluck(:amount).sum
  end

  def total_weekly_capacity
    logs.from_weeks_ago.pluck(:amount).sum
  end

  def remaining_recent_capacity
    weekly_expected_capacity - total_recent_capacity
  end

  def remaining_weekly_capacity
    weekly_expected_capacity - total_weekly_capacity
  end
end
