# frozen_string_literal: true

# Provides a seam that allows us to inject common behavior across models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
