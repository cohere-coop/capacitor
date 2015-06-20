require "rails_helper"

feature "Edit projects" do
  include_context "account login"

  Given { @project = FactoryGirl.create(:project, name: "Project A", capacity: 10 ) }
  Given { @decorated_project = @project.decorate }


  When { within("##{@decorated_project.dom_id}") { click_link_or_button "Edit" } }
  When { fill_in "Capacity", with: 8 }
  When { click_link_or_button "Save" }

  Then { expect(@project.reload.capacity).to eql(8) }
end
