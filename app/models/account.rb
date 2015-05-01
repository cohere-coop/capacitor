class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :capacities, foreign_key: :worker_id
  has_many :projects, through: :capacities
  has_many :owned_projects, class_name: "Project", foreign_key: :client_id
end
