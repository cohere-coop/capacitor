class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"
  belongs_to :project

  validates :name, :project_id, presence: true
end
