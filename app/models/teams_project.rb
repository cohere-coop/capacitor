class TeamsProject < ActiveRecord::Base
  belongs_to :team
  belongs_to :project

  validates :team, :project, presence: true
end
