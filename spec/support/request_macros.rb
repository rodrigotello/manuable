module RequestMacros
  include Warden::Test::Helpers

  # for use in request specs
  def sign_in_as_a_user
    Warden.test_mode!
    @current_user ||= FactoryGirl.create :user
    login_as @current_user, :scope => :user
  end

  def take_screenshot
    page.save_screenshot("tmp/capybara/#{Time.now.to_i}.png")
  end
end
