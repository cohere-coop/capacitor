require 'rails_helper'

feature 'update capacity remaining' do
  include_context "account login"

  Given!(:project) { FactoryGirl.create(:project, total_capacity_owed: 10) }

  When { click_link_or_button project.name }

  When { select("1 half-day", from: "Amount") }
  When { select("4", from: "Quality") }
  When { fill_in("Worked at", with: "2015-05-06") }

  When { click_link_or_button "Log Capacity"}
  Then { expect(project.reload.capacity_remaining).to eq(6)}
end

