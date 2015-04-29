class Project < ActiveRecord::Base

  has_many :hours
  has_many :days
  has_many :users
  belongs_to :client, touch: true


  def project_id

  end

  def label
   name
  end
end
