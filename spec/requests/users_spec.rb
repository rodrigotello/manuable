require 'spec_helper'

describe 'user profile' do

  it "shows profile" do
    sign_in_as_a_user
    user = FactoryGirl.create(:user)
    visit user_path(user)

    page.should have_content(user.name)
    page.should have_css('img', text: user.avatar.url)
    page.should have_content(user.about[0, 300])
    page.should have_content('Seguir')
    page.should have_content('Seguidores')
    page.should have_content('Siguiendo')

  end

  it "shows panel user followers" do
    sign_in_as_a_user
    user = FactoryGirl.create(:user)
    follower1 = FactoryGirl.create(:user)
    follower2 = FactoryGirl.create(:user)
    follower3 = FactoryGirl.create(:user)
    follower1.follow_to!(user)
    follower2.follow_to!(user)
    follower3.follow_to!(user)

    visit user_path(user)

    page.should have_content(follower1.name)
    page.should have_css('img', text: follower1.avatar.url)
    page.should have_content(follower2.name)
    page.should have_css('img', text: follower2.avatar.url)
    page.should have_content(follower3.name)
    page.should have_css('img', text: follower3.avatar.url)
  end

  it "shows panel user followees" do
    sign_in_as_a_user
    user = FactoryGirl.create(:user)
    followee1 = FactoryGirl.create(:user)
    followee2 = FactoryGirl.create(:user)
    followee3 = FactoryGirl.create(:user)
    user.follow_to!(followee1)
    user.follow_to!(followee2)
    user.follow_to!(followee3)

    visit user_path(user)

    page.should have_content(followee1.name)
    page.should have_css('img', text: followee1.avatar.url)
    page.should have_content(followee2.name)
    page.should have_css('img', text: followee2.avatar.url)
    page.should have_content(followee3.name)
    page.should have_css('img', text: followee3.avatar.url)
  end

end