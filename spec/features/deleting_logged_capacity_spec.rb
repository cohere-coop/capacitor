require "rails_helper"

feature "Logging time" do
  include_context "account login"
  Given!(:log) { FactoryGirl.create(:recent_log, account: current_account).decorate }
  When { within("##{log.dom_id}") { click_link_or_button("Delete") } }
  Then { expect { Log.find(log.id) }.to raise_error(ActiveRecord::RecordNotFound) }
end
