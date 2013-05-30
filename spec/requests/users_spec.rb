require 'spec_helper'

describe 'user profile' do

  it "shows profile" do
    sign_in_as_a_user
    user = FactoryGirl.create(:user)
    visit user_path(user)

    page.should have_content(user.name)
    page.should have_content("Nacido el #{I18n.l user.birthday, format: :birthday}" )
    page.should have_content(user.occupation)
    page.should have_xpath("//img[@src=\"#{user.avatar.url(:medium)}\"]")
    page.should have_content(user.about[0, 100])
    page.should have_content('Seguir')
    page.should_not have_content('Seguidores')
    page.should_not have_content('Siguiendo')

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

    page.find("#follower-#{follower1.id}").should have_content(follower1.name)
    page.find("#follower-#{follower1.id}").should have_xpath("//img[@src=\"#{follower1.avatar.url(:thumb)}\"]")
    page.find("#follower-#{follower2.id}").should have_content(follower2.name)
    page.find("#follower-#{follower2.id}").should have_xpath("//img[@src=\"#{follower2.avatar.url(:thumb)}\"]")
    page.find("#follower-#{follower3.id}").should have_content(follower3.name)
    page.find("#follower-#{follower3.id}").should have_xpath("//img[@src=\"#{follower3.avatar.url(:thumb)}\"]")
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

    page.find("#followee-#{followee1.id}").should have_content(followee1.name)
    page.find("#followee-#{followee1.id}").should have_xpath("//img[@src=\"#{followee1.avatar.url(:thumb)}\"]")
    page.find("#followee-#{followee2.id}").should have_content(followee2.name)
    page.find("#followee-#{followee2.id}").should have_xpath("//img[@src=\"#{followee2.avatar.url(:thumb)}\"]")
    page.find("#followee-#{followee3.id}").should have_content(followee3.name)
    page.find("#followee-#{followee3.id}").should have_xpath("//img[@src=\"#{followee3.avatar.url(:thumb)}\"]")
  end

  it 'shows user feed(nofilter)' do
    sign_in_as_a_user
    viewed_user = FactoryGirl.create(:user)
    follewee1 = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee2 = FactoryGirl.create(:user_with_products, products_count: 3)
    follewee3 = FactoryGirl.create(:user_with_products, products_count: 1)
    member1 = FactoryGirl.create(:user_with_products, products_count: 2)
    member2 = FactoryGirl.create(:user_with_products, products_count: 2)

    viewed_user.follow_to! follewee1
    viewed_user.follow_to! follewee2
    viewed_user.follow_to! follewee3
    liked_products = [member2.products.first, member1.products.first].each do |p|
      viewed_user.like! p
    end

    visit user_path(viewed_user, per_page: 10)

    page.should have_css('.activities .activity', count: 8)
    (follewee1.products + follewee2.products + follewee3.products + liked_products).each do |product|
      page.should have_css("#product_#{product.id}.activity")
    end
  end

  it 'shows user feed( liked filter)' do
    sign_in_as_a_user
    viewed_user = FactoryGirl.create(:user)
    follewee1 = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee2 = FactoryGirl.create(:user_with_products, products_count: 3)
    follewee3 = FactoryGirl.create(:user_with_products, products_count: 1)
    member1 = FactoryGirl.create(:user_with_products, products_count: 2)
    member2 = FactoryGirl.create(:user_with_products, products_count: 2)

    viewed_user.follow_to! follewee1
    viewed_user.follow_to! follewee2
    viewed_user.follow_to! follewee3
    liked_products = [member2.products.first, member1.products.first].each do |p|
      viewed_user.like! p
    end

    visit user_path(viewed_user, per_page: 10, f: 'l')

    page.should have_css('.activities .activity', count: 2)
    liked_products.each do |product|
      page.should have_css("#product_#{product.id}.activity")
    end
  end

  it 'shows user feed( shared filter )' do
    sign_in_as_a_user
    viewed_user = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee1 = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee2 = FactoryGirl.create(:user_with_products, products_count: 3)
    follewee3 = FactoryGirl.create(:user_with_products, products_count: 1)
    member1 = FactoryGirl.create(:user_with_products, products_count: 2)
    member2 = FactoryGirl.create(:user_with_products, products_count: 2)

    viewed_user.follow_to! follewee1
    viewed_user.follow_to! follewee2
    viewed_user.follow_to! follewee3
    liked_products = [member2.products.first, member1.products.first].each do |p|
      viewed_user.like! p
    end

    visit user_path(viewed_user, per_page: 12, f: 'p')

    page.should have_css('.activities .activity', count: 2)
    viewed_user.products.each do |product|
      page.should have_css("#product_#{product.id}.activity")
    end
  end

  it 'guest: shows user feed(nofilter)' do
    viewed_user = FactoryGirl.create(:user)
    follewee1 = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee2 = FactoryGirl.create(:user_with_products, products_count: 3)
    follewee3 = FactoryGirl.create(:user_with_products, products_count: 1)
    member1 = FactoryGirl.create(:user_with_products, products_count: 2)
    member2 = FactoryGirl.create(:user_with_products, products_count: 2)

    viewed_user.follow_to! follewee1
    viewed_user.follow_to! follewee2
    viewed_user.follow_to! follewee3
    liked_products = [member2.products.first, member1.products.first].each do |p|
      viewed_user.like! p
    end

    visit user_path(viewed_user, per_page: 10)

    page.should have_css('.activities .activity', count: 8)
    (follewee1.products + follewee2.products + follewee3.products + liked_products).each do |product|
      page.should have_css("#product_#{product.id}.activity")
    end
  end

  it 'guest: shows user feed( liked filter)' do
    viewed_user = FactoryGirl.create(:user)
    follewee1 = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee2 = FactoryGirl.create(:user_with_products, products_count: 3)
    follewee3 = FactoryGirl.create(:user_with_products, products_count: 1)
    member1 = FactoryGirl.create(:user_with_products, products_count: 2)
    member2 = FactoryGirl.create(:user_with_products, products_count: 2)

    viewed_user.follow_to! follewee1
    viewed_user.follow_to! follewee2
    viewed_user.follow_to! follewee3
    liked_products = [member2.products.first, member1.products.first].each do |p|
      viewed_user.like! p
    end

    visit user_path(viewed_user, per_page: 10, f: 'l')

    page.should have_css('.activities .activity', count: 2)
    liked_products.each do |product|
      page.should have_css("#product_#{product.id}.activity")
    end
  end

  it 'guest: shows user feed( shared filter )' do
    viewed_user = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee1 = FactoryGirl.create(:user_with_products, products_count: 2)
    follewee2 = FactoryGirl.create(:user_with_products, products_count: 3)
    follewee3 = FactoryGirl.create(:user_with_products, products_count: 1)
    member1 = FactoryGirl.create(:user_with_products, products_count: 2)
    member2 = FactoryGirl.create(:user_with_products, products_count: 2)

    viewed_user.follow_to! follewee1
    viewed_user.follow_to! follewee2
    viewed_user.follow_to! follewee3
    liked_products = [member2.products.first, member1.products.first].each do |p|
      viewed_user.like! p
    end

    visit user_path(viewed_user, per_page: 12, f: 'p')

    page.should have_css('.activities .activity', count: 2)
    viewed_user.products.each do |product|
      page.should have_css("#product_#{product.id}.activity")
    end
  end
end


