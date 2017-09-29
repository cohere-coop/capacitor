# frozen_string_literal: true

require "rails_helper"

describe Membership do
  it { is_expected.to validate_presence_of(:account) }
  it { is_expected.to validate_presence_of(:team) }
  it { is_expected.to validate_inclusion_of(:level).in_array(%w[member leader]) }
  describe "#errors" do
    subject(:membership_errors) { membership.errors }

    let(:other_membership) { FactoryGirl.create(:membership) }

    before { membership.valid? }
    context "when a membership has the same team and account as another membership" do
      let(:membership) do
        FactoryGirl.build(:membership, account:
                          other_membership.account, team:
                          other_membership.team)
      end

      it { is_expected.to be_added(:account, "has already been taken") }
    end

    context "when a membership has the same account on a different team" do
      let(:membership) { FactoryGirl.build(:membership, account: other_membership.account) }

      it { is_expected.not_to be_added(:account, "has already been taken") }
    end
  end
end
