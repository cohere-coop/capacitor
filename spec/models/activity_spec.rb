# frozen_string_literal: true

require "rails_helper"

describe Activity do
  context "scopes" do
    let!(:active_activity) { FactoryGirl.create(:activity, active: true) }
    let!(:inactive_activity) { FactoryGirl.create(:activity, active: false) }

    describe "active" do
      subject { described_class.all.active }

      it { is_expected.to include(active_activity) }
      it { is_expected.not_to include(inactive_activity) }
    end
  end

  describe "#weekly_capacity_remaining" do
    it "subtracts the recently logged amount from the weekly burn rate" do
      activity = FactoryGirl.create(:activity, weekly_burn_rate: 12)
      FactoryGirl.create(:todays_log, amount: 5, activity: activity)
      expect(activity.weekly_capacity_remaining).to be(7)
    end

    it "does not subract do not bill logs" do
      activity = FactoryGirl.create(:activity, weekly_burn_rate: 12)
      FactoryGirl.create(:recent_log, amount: 5, activity: activity, do_not_bill: true)
      expect(activity.weekly_capacity_remaining).to be(12)
    end
  end
  describe "#capacity_remaining" do
    it "does not take into account non-billable work" do
      activity = FactoryGirl.create(:activity, capacity: 12)
      FactoryGirl.create(:recent_log, amount: 5, activity: activity, do_not_bill: true)
      expect(activity.capacity_remaining).to be(12)
    end
  end
  describe "#quality_by_week" do
    let(:activity) { FactoryGirl.create(:activity) }

    it "averages each week's quality into a hash" do
      log1 = FactoryGirl.create(:recent_log, activity: activity, quality: 5)
      FactoryGirl.create(:recent_log, activity: activity, quality: 1)
      expect(activity.quality_by_week).to include(log1.worked_at.beginning_of_week => 3)
    end
    it "handles more than one week effectively" do
      log1 = FactoryGirl.create(:log, activity: activity, quality: 5, worked_at: 1.week.ago)
      log2 = FactoryGirl.create(:log, activity: activity, quality: 1, worked_at: 2.weeks.ago)
      expect(activity.quality_by_week).to include(log1.worked_at.beginning_of_week => 5,
                                                  log2.worked_at.beginning_of_week => 1)
    end
    it "rounds non-even numbers instead of truncating them" do
      log1 = FactoryGirl.create(:recent_log, activity: activity, quality: 4)
      FactoryGirl.create(:recent_log, activity: activity, quality: 1)
      expect(activity.quality_by_week).to include(log1.worked_at.beginning_of_week => 3)
    end
    it "only includes up to eight weeks" do
      FactoryGirl.create(:log, activity: activity, quality: 5, worked_at: 10.weeks.ago)
      expect(activity.quality_by_week).to be_empty
    end
  end
end
