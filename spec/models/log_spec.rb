# frozen_string_literal: true

require "rails_helper"

describe Log do
  describe "#filter" do
    describe "no filters" do
      Given(:old_log) { FactoryGirl.create(:old_log) }
      Given(:recent_log) { FactoryGirl.create(:recent_log) }

      subject(:results) { described_class.filter({}) }

      it { is_expected.to include(recent_log) }
      it { is_expected.to include(old_log) }
    end

    describe "filtering by after_date" do
      Given(:old_log) { FactoryGirl.create(:old_log) }
      Given(:recent_log) { FactoryGirl.create(:recent_log) }

      subject(:results) { described_class.filter(after_date: 3.days.ago.to_date) }

      it { is_expected.to include(recent_log) }
      it { is_expected.not_to include(old_log) }
    end

    describe "filtering by before date" do
      Given(:old_log) { FactoryGirl.create(:old_log) }
      Given(:recent_log) { FactoryGirl.create(:recent_log) }

      subject(:results) { described_class.filter(before_date: 3.days.ago.to_date) }

      it { is_expected.not_to include(recent_log) }
      it { is_expected.to include(old_log) }
    end

    describe "Filtering by billable" do
      Given(:billable_log) { FactoryGirl.create(:log, do_not_bill: false) }
      Given(:unbillable_log) { FactoryGirl.create(:log, do_not_bill: true) }

      subject(:results) { described_class.filter(billable: true) }

      it { is_expected.to include(billable_log) }
      it { is_expected.not_to include(unbillable_log) }
    end

    describe "Filtering by activity" do
      Given(:activity_a) { FactoryGirl.create(:activity) }
      Given(:activity_b) { FactoryGirl.create(:activity) }
      Given(:activity_a_log) { FactoryGirl.create(:log, activity: activity_a) }
      Given(:activity_b_log) { FactoryGirl.create(:log, activity: activity_b) }

      subject { described_class.filter(activities: [activity_a.id]) }

      it { is_expected.to include(activity_a_log) }
      it { is_expected.not_to include(activity_b_log) }
    end
  end
end
