module CheckIns
  # ViewModel exposing check ins specific functionality for a given account
  class Account < SimpleDelegator
    def recent_check_ins
      RecentQuery.new(check_ins).results
    end
  end

  # Given a ActiveRecordRelation of check ins, provides a collection of check ins
  # with missing check ins filled in.
  class RecentQuery
    DAYS_BACK_TO_CONSIDER_RECENT = 7
    attr_reader :check_ins

    def initialize(check_ins)
      @check_ins = check_ins
    end

    def results
      Array.new(DAYS_BACK_TO_CONSIDER_RECENT) do |number|
        check_in_worked_at(number.days.ago.to_date)
      end
    end

    private def recent_check_ins
      @recent_check_ins ||= check_ins.recent.to_a
    end

    private def check_in_worked_at(date)
      (recent_check_ins.find { |check_in| check_in.worked_at == date } ||
        check_ins.new(worked_at: date))
    end
  end
end
