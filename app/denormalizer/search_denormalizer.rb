class SearchDenormalizer
  ALLOWED_SCOPES = ["recent", "weekly", "for_project", "billable"]

  def initialize(parameters)
    @scopes = parameters[:scopes] || []
    @arguments = ALLOWED_SCOPES.inject({}) do |query, scope|
      query.merge(scope => parameters[scope] || [])
    end
  end

  def scopes
    @scopes.select do |scope|
      ALLOWED_SCOPES.include?(scope)
    end
  end

  def arguments
    @arguments
  end
end
