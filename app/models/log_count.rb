class LogCount < ActiveRecord::Base
    scope: eight_weeks_ago do
        where(created_at: 8.weeks.ago)
    end
end
