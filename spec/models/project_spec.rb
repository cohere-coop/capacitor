require 'rails_helper'

describe Project do
  describe "capacity_remaining_this_week" do
    it "subtracts the recently logged amount from the weekly burn rate" do
      project = FactoryGirl.create(:project, weekly_burn_rate: 12)
      FactoryGirl.create(:recent_log, amount: 5, project: project)
      expect(project.capacity_remaining_this_week).to eql(7)
    end
  end
end
