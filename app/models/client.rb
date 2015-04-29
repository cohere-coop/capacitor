class Client < ActiveRecord::Base

  has_many :hours, through: :project
  has_many :days, through: :project
  has_many :project


end
