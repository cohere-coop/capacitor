class Account
  class SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token, only: :destroy
    # POST /resource/sign_in
    def create
      super do
        track_event("Account logged in")
      end
    end
  end
end
