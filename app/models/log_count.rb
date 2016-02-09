class LogCount < ActiveRecord::Base
    scope: two_months_ago do
        where(created_at: 2.months.ago)
    end
end
