require "rails_helper"

RSpec.describe Account, type: :model do
  it "auto-generates a uuid at the database level" do
    account = FactoryGirl.create(:account)
    # We reload to pull the fields back from the DB since
    # Rails doesn't know about the default value that was
    # set on creation by postgresql.

    account.reload
    expect(account.uuid).to be_present
  end
end
