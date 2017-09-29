require 'rails_helper'

describe TeamsActivity do
  it { is_expected.to validate_presence_of(:team) }
  it { is_expected.to validate_presence_of(:activity) }
  it "scopes uniqueness of activity to team" do
    teams_activity_a = FactoryGirl.create(:teams_activity)
    teams_activity_b = FactoryGirl.build(:teams_activity, 
                                         activity: teams_activity_a.activity, 
                                         team: teams_activity_a.team)

    teams_activity_c = FactoryGirl.build(:teams_activity, 
                                         activity: teams_activity_a.activity)

    teams_activity_b.valid?
    expect(teams_activity_b.errors).to be_added(:activity, 'has already been taken')

    teams_activity_c.valid?
    expect(teams_activity_c.errors).not_to be_added(:activity, 'has already been taken')
  end
end
