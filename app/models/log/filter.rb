class Log < ActiveRecord::Base
  class Filter
    attr_reader :collection, :conditions
    def initialize(collection:, conditions: {})
      @collection = collection
      @conditions = conditions
    end

    def results
      clauses.reduce(collection) do |search_query, clause|
        filter_clause(search_query, clause)
      end
    end

    private

    def clauses
      clauses = []
      clauses += time_clauses
      clauses += project_clauses
      clauses
    end

    def time_clauses
      clauses = []
      clauses.push(["worked_at >= ?", conditions[:after_date]]) if conditions[:after_date]
      clauses.push(["worked_at <= ?", conditions[:before_date]]) if conditions[:before_date]
      clauses
    end

    def project_clauses
      clauses = []
      clauses.push(project_id: conditions[:projects]) if conditions[:projects]
      clauses.push(do_not_bill: false) if conditions[:billable]
      clauses
    end

    def filter_clause(collection, clause)
      if clause.respond_to?(:keys)
        collection.where(clause)
      else
        field, condition = clause
        collection.where(field, condition)
      end
    end
  end
end
