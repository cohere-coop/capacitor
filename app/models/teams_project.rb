# Linking table between teams and projects. Contains permissions for who
# can see/edit/etc. which projects
class TeamsProject < ActiveRecord::Base
  belongs_to :team
  belongs_to :project

  validates :team, :project, presence: true
end
