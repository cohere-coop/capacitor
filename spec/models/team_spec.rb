# frozen_string_literal: true

require "rails_helper"

RSpec.describe Team, type: :model do
  it "validates the presence of name" do
    expect { FactoryGirl.create(:team, name: "") }.to raise_error(ActiveRecord::RecordInvalid,
                                                                  "Validation failed: Name can't be blank")
  end

  it "validates uniqueness of name by leader" do
    team = FactoryGirl.create(:team, name: "Unicorns")

    expect do
      FactoryGirl.create(:team, name: "Unicorns", leader: team.leader)
    end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name has already been taken")
  end
end
