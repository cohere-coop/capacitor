# frozen_string_literal: true

require "rails_helper"

RSpec.describe Team, type: :model do
  it "validates the presence of name" do
    expect { FactoryGirl.create(:team, name: "") }.to raise_error(ActiveRecord::RecordInvalid,
                                                                  "Validation failed: Name can't be blank")
  end
end
