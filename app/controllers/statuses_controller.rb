# frozen_string_literal: true

# Health checks!
class StatusesController < ApplicationController
  skip_before_action :authenticate_account!
  def show
    render plain: "ok"
  end
end
