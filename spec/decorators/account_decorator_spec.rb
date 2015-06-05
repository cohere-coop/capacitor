require "rails_helper"

RSpec.describe AccountDecorator, type: :decorator do
  let(:account) do
    instance_double(Account)
  end

  let(:decorator) do
    described_class.new(account)
  end

  before(:each) do
    allow(account).to receive(:weekly_expected_capacity).and_return(weekly_expected_capacity_value)
  end

  describe "#weekly_expected_capacity" do
    let(:weekly_expected_capacity_value) do
      40
    end

    let(:weekly_expected_capacity) do
      decorator.weekly_expected_capacity
    end

    it "returns the correct business days" do
      expect(weekly_expected_capacity).to eq("5 days")
    end
  end
end
