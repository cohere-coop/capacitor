class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"
  belongs_to :project

  validates :name, :project, presence: true
end
