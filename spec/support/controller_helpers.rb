module ControllerHelpers
  def sign_in(account)
    allow(request.env["warden"]).to receive(:authenticate!).and_return(account)
    allow(controller).to receive(:current_account).and_return(account)
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
end
