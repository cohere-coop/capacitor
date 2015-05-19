class PagesController < ApplicationController
  before_action :authenticate_account!

  def dashboard
  end

end
