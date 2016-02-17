require "rails_helper"

describe Log do
  describe "#filter" do
    it "returns everything if no filters" do
      old_log = FactoryGirl.create(:old_log)
      recent_log = FactoryGirl.create(:recent_log)

      results = described_class.filter({})
      expect(results).to include(recent_log)
      expect(results).to include(old_log)
    end

    it "filters after_date" do
      old_log = FactoryGirl.create(:old_log)
      recent_log = FactoryGirl.create(:recent_log)

      results = described_class.filter(after_date: 3.days.ago.to_date)
      expect(results).to include(recent_log)
      expect(results).not_to include(old_log)
    end

    it "filters before_date" do
      old_log = FactoryGirl.create(:old_log)
      recent_log = FactoryGirl.create(:recent_log)

      results = described_class.filter(before_date: 3.days.ago.to_date)
      expect(results).not_to include(recent_log)
      expect(results).to include(old_log)
    end

    it "filters billable" do
      billable_log = FactoryGirl.create(:log, do_not_bill: false)
      unbillable_log = FactoryGirl.create(:log, do_not_bill: true)

      results = described_class.filter(billable: true)
      expect(results).not_to include(unbillable_log)
      expect(results).to include(billable_log)
    end

    it "filters activities" do
      activity_a = FactoryGirl.create(:activity)
      activity_b = FactoryGirl.create(:activity)
      activity_a_log = FactoryGirl.create(:log, activity: activity_a)
      activity_b_log = FactoryGirl.create(:log, activity: activity_b)

      results = described_class.filter(activities: [activity_a.id])
      expect(results).not_to include(activity_b_log)
      expect(results).to include(activity_a_log)
    end
  end
end
