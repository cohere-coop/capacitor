
# frozen_string_literal: true

class Account
  # Overrides `create` for tracking purposes
  class SessionsController < Devise::SessionsController
    # POST /resource/sign_in
    def create
      super do
        track_event("Account logged in")
      end
    end
  end
end
