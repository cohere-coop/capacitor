# frozen_string_literal: true

require "rails_helper"

describe TeamsActivity do
  it { is_expected.to validate_presence_of(:team) }
  it { is_expected.to validate_presence_of(:activity) }
  describe "#errors" do
    subject(:teams_activity_errors) { teams_activity.errors }

    let(:other_teams_activity) { FactoryGirl.create(:teams_activity) }

    before { teams_activity.valid? }
    context "when a teams_activity has the same team and activity as another teams_activity" do
      let(:teams_activity) do
        FactoryGirl.build(:teams_activity, activity:
                          other_teams_activity.activity, team:
                          other_teams_activity.team)
      end

      it { is_expected.to be_added(:activity, "has already been taken") }
    end

    context "when a teams_activity has the same activity on a different team" do
      let(:teams_activity) { FactoryGirl.build(:teams_activity, activity: other_teams_activity.activity) }

      it { is_expected.not_to be_added(:activity, "has already been taken") }
    end
  end
end
