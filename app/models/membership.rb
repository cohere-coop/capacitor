class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :account

  validates :team, :account, presence: true
end
