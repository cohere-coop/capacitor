# frozen_string_literal: true

FactoryGirl.define do
  factory :membership do
    team
    account
  end
end
