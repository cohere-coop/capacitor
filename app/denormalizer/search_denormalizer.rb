class SearchDenormalizer
  DEFAULT_SCOPES = Array.new
  ALLOWED_SCOPES = ["recent", "weekly", "for_project", "billable", "order"]

  def initialize(parameters)
    @scopes = parameters[:scopes] || DEFAULT_SCOPES
    @arguments = ALLOWED_SCOPES.inject({}) do |query, scope|
      query.merge(scope => parameters[scope])
    end
  end

  def scopes
    @scopes.select do |scope|
      ALLOWED_SCOPES.include?(scope)
    end
  end

  def for_project
    @arguments["for_project"]
  end

  def weekly
    (@arguments["weekly"].to_i || 0).weeks
  end

  def recent
    @arguments["recent"].to_i.days.ago
  end

  def order
    @arguments["order"]
  end
end
