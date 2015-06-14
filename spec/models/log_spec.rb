require 'rails_helper'
describe Log do
  describe "#filter" do
    it "filters after_date" do
      old_log = FactoryGirl.create(:old_log)
      recent_log = FactoryGirl.create(:recent_log)

      results = Log.filter({ after_date: 3.days.ago.to_date})
      expect(results).to include(recent_log)
      expect(results).not_to include(old_log)
    end

    it "filters before_date" do
      old_log = FactoryGirl.create(:old_log)
      recent_log = FactoryGirl.create(:recent_log)

      results = Log.filter({ before_date: 3.days.ago.to_date})
      expect(results).not_to include(recent_log)
      expect(results).to include(old_log)
    end

    it  "filters billable" do
      billable_log = FactoryGirl.create(:log, do_not_bill: false)
      unbillable_log = FactoryGirl.create(:log, do_not_bill: true)

      results = Log.filter({ billable: true })
      expect(results).not_to include(unbillable_log)
      expect(results).to include(billable_log)
    end

    it "filters projects" do
      project_a = FactoryGirl.create(:project)
      project_b = FactoryGirl.create(:project)
      project_a_log = FactoryGirl.create(:log, project: project_a)
      project_b_log = FactoryGirl.create(:log, project: project_b)

      results = Log.filter({ projects: [project_a.id] })
      expect(results).not_to include(project_b_log)
      expect(results).to include(project_a_log)
    end
  end
end
