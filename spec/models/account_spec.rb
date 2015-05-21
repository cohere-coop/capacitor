require "rails_helper"

RSpec.describe Account, type: :model do
  let(:account) do
    FactoryGirl.create(:account, name: name)
  end
  let(:name) do
    "Casper"
  end
  it "auto-generates a uuid at the database level" do
    # We reload to pull the fields back from the DB since
    # Rails doesn't know about the default value that was
    # set on creation by postgresql.
    account.reload
    expect(account.uuid).to be_present
  end
  context "validations" do
    describe "name" do
      let(:name) do
        ""
      end
      it "detects lack of name" do
        expect{account}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
      end
    end
  end
end
