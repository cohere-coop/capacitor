# frozen_string_literal: true

FactoryGirl.define do
  factory :team do
    sequence(:name) { |i| "Team #{i}" }
  end
end
