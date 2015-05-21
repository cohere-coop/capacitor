require "rails_helper"

RSpec.describe Account, type: :model do
  let(:account) do
    FactoryGirl.create(:account, name: name, email: email)
  end

  let(:name) do
    "Casper"
  end

  let(:email) do
    "casper@example.com"
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
        expect { account }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
      end
    end

    describe "email" do
      context "with a blank email" do
        let(:email) do
          ""
        end

        it "detects lack of email" do
          expect { account }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank")
        end
      end

      context "with a non-unique email" do
        it "doesn't allow non-unique emails" do
          FactoryGirl.create(:account, name: name, email: email)
          expect { account }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email has already been taken")
        end
      end
    end
  end
end
