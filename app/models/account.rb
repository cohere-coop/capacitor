# frozen_string_literal: true

# Individual person
class Account < ActiveRecord::Base
  devise :database_authenticatable
  devise :registerable
  devise :recoverable
  devise :rememberable
  devise :trackable
  devise :validatable

  has_many :logs
  has_many :owned_activities, foreign_key: :owner_id,
                              source: :activity, class_name: "Activity"
  has_many :check_ins

  has_many :memberships
  has_many :teams, through: :memberships
  has_many :owned_teams, -> { where(memberships: { level: "leader" }) },
           through: :memberships, source: :team, class_name: "Team"

  validates :name, presence: true

  has_many :oauth_applications, class_name: "Doorkeeper::Application", as: :owner
  serialize :features, Features

  def activities
    LoggableActivitiesQuery.new(account: self).records
  end

  def enable_feature(feature)
    features.send(:"#{feature}=", true)
    save
  end

  def disable_feature(feature)
    features.send(:"#{feature}=", false)
    save
  end

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
