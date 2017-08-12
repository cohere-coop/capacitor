# frozen_string_literal: true

require "rails_helper"

RSpec.describe TeamsController, type: :controller do
  describe "#edit" do
    context "When not the team owner" do
      Given(:team) { FactoryGirl.create(:team) }
      Given(:account) { FactoryGirl.create(:account) }
      Given { sign_in(account) }

      When { get :edit, params: { id: team.id } }

      Then { expect(response.status).to eq(302) }
      And { expect(response).to redirect_to(teams_path) }
    end
  end
end
