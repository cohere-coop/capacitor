# frozen_string_literal: true

class Account
  # Override of Devise Regisrations Controller to track events + allow custom data
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      super do |account|
        if account.persisted?
          account.reload
          track_event("Account created")
        else
          track_event("Account creation failed")
        end
      end
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # You can put the params you want to permit in the empty array.
    def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) << %i[name time_zone]
    end

    # You can put the params you want to permit in the empty array.
    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) << %i[name time_zone]
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
