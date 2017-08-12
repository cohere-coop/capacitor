# frozen_string_literal: true

# Linking table between teams and activities. Contains permissions for who
# can see/edit/etc. which activities
class TeamsActivity < ActiveRecord::Base
  belongs_to :team
  belongs_to :activity

  validates :team, :activity, presence: true
end
