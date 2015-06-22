require "rails_helper"

describe Project do
  describe "#weekly_capacity_remaining" do
    it "subtracts the recently logged amount from the weekly burn rate" do
      project = FactoryGirl.create(:project, weekly_burn_rate: 12)
      FactoryGirl.create(:recent_log, amount: 5, project: project, worked_at: 0.weeks.ago)
      expect(project.weekly_capacity_remaining).to eql(7)
    end

    it "does not subract do not bill logs" do
      project = FactoryGirl.create(:project, weekly_burn_rate: 12)
      FactoryGirl.create(:recent_log, amount: 5, project: project, do_not_bill: true)
      expect(project.weekly_capacity_remaining).to eql(12)
    end
  end
  describe "#capacity_remaining" do
    it "does not take into account non-billable work" do
      project = FactoryGirl.create(:project, capacity: 12)
      FactoryGirl.create(:recent_log, amount: 5, project: project, do_not_bill: true)
      expect(project.capacity_remaining).to eql(12)
    end
  end
  describe "#quality_by_week" do
    let(:project) { FactoryGirl.create(:project) }
    it "averages each week's quality into a hash" do
      log1 = FactoryGirl.create(:log, project: project, quality: 5)
      FactoryGirl.create(:log, project: project, quality: 1)
      expect(project.quality_by_week).to include(log1.worked_at.beginning_of_week => 3)
    end
    it "handles more than one week effectively" do
      log1 = FactoryGirl.create(:log, project: project, quality: 5, worked_at: "2015-05-06")
      log2 = FactoryGirl.create(:log, project: project, quality: 1, worked_at: "2015-06-01")
      expect(project.quality_by_week).to include(log1.worked_at.beginning_of_week => 5,
                                                 log2.worked_at.beginning_of_week => 1)
    end
    it "rounds non-even numbers instead of truncating them" do
      log1 = FactoryGirl.create(:log, project: project, quality: 4)
      FactoryGirl.create(:log, project: project, quality: 1)
      expect(project.quality_by_week).to include(log1.worked_at.beginning_of_week => 3)
    end
  end
end
