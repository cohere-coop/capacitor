# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    registrations: "account/registrations",
    sessions: "account/sessions"
  }

  resources :check_ins, only: %i[new create edit update]

  resources :activities, only: %i[index new create edit update] do
    resources :logs, only: %i[new create edit update]
  end

  resources :logs, only: %i[index destroy]

  resources :teams

  root to: "pages#dashboard"
end
