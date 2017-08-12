# frozen_string_literal: true

require "rails_helper"

describe AccountOwnsAllPolicy do
  subject(:policy) { described_class.new(account) }

  let(:account) { FactoryGirl.create(:account_who_checked_in_yesterday) }

  it "raises an exception when the account doesn't doesn't own all of the passed in attributes" do
    expect do
      policy.ensure_access!({ 0 => { id: account.check_ins.first.id }, 1 => { id: 235 } }, :id, :check_ins)
    end.to raise_error UnauthorizedActionError
  end

  it "does not raise when the account owns all the passed in attributes" do
    expect do
      policy.ensure_access!({ 0 => { id: account.check_ins.first.id } }, :id, :check_ins)
    end.not_to raise_error
  end
end
