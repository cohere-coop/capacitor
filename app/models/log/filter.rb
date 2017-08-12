# frozen_string_literal: true

class Log < ActiveRecord::Base
  # Reduces a collection of logs based on conditions by building up an AREL Where Query
  class Filter
    attr_reader :collection, :conditions
    def initialize(collection:, conditions: {})
      @collection = collection
      @conditions = conditions
    end

    def results
      clauses.reduce(collection) do |collection, clause|
        filter(collection, clause)
      end
    end

    private

    def clauses
      clauses = []
      clauses += time_clauses
      clauses += activity_clauses
      clauses
    end

    def time_clauses
      clauses = []
      clauses.push(["worked_at >= ?", conditions[:after_date]]) if conditions[:after_date]
      clauses.push(["worked_at <= ?", conditions[:before_date]]) if conditions[:before_date]
      clauses
    end

    def activity_clauses
      clauses = []
      clauses.push(activity_id: conditions[:activities]) if conditions[:activities]
      clauses.push(do_not_bill: false) if conditions[:billable]
      clauses
    end

    def filter(collection, clause)
      if clause.respond_to?(:keys)
        collection.where(clause)
      else
        field, condition = clause
        collection.where(field, condition)
      end
    end
  end
end
