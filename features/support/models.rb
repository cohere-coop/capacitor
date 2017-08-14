# frozen_string_literal: true

# Plain old ruby object that can stand in as the account model for our feature
# tests
class Account
  attr_accessor :email, :name, :password
  def initialize(email: nil, name: nil, password: nil)
    self.email = email
    self.name = name
    self.password = password
  end
end
