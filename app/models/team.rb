class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"

  validates :leader, presence: true
end
