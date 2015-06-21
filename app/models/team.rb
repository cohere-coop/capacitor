class Team < ActiveRecord::Base
  belongs_to :leader, class_name: "Account"
end
