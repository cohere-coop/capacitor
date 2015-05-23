require "spec_helper"

escribe ProjectDecorator do
  let(:project) { FactoryGirl.build_stubbed(:project).decorate }

  it "returns decorated project link " do
    assigns(:project).should_be_decorated_by ProjectDecorator
  end
end
