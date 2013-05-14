require 'spec_helper'

describe 'follow/unfollow user' do

  it 'follow user', :js => true do
    sign_in_as_a_user
    user = FactoryGirl.create(:user)

    visit user_path(user)
    click_link 'Seguir'

    page.should have_content('Siguiendo')

  end

  # it 'unfollow user' do

  # end

end
