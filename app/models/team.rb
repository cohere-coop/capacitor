class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account", foreign_key: "leader_id"
end
