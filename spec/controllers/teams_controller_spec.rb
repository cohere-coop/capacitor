require "rails_helper"

RSpec.describe TeamsController, type: :controller do
  describe "#edit" do
    it "forbids non-owners" do
      team = FactoryGirl.create(:team)
      account = FactoryGirl.create(:account)

      sign_in(account)

      get :edit, id: team.id
      expect(response.status).to eq(302)
      expect(response).to redirect_to(teams_path)
    end
  end
end
