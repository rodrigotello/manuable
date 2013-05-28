require 'spec_helper'

describe 'follow/unfollow user' do

  it 'follow user' do
    sign_in_as_a_user
    user = FactoryGirl.create(:user)

    visit user_path(user)
    click_link 'Seguir'

    page.should have_content('Seguidores')

    follower_div = page.find("#follower-#{@current_user.id}")
    follower_div.should have_content(@current_user.name)
    follower_div.should have_xpath("//img[@src=\"#{@current_user.avatar.url(:thumb)}\"]")
  end

  # it 'unfollow user' do

  # end

end
