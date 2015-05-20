class Account::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    super do |account_login|
      track_event("Account logged in")
    end
  end
end
