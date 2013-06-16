require 'spec_helper'

describe "Like Notifications" do
  it "notifies the user about the like" do
    liker1 = FactoryGirl.create(:user)
    liker2 = FactoryGirl.create(:user)
    user_to_notificate = FactoryGirl.create(:user_with_products, products_count: 2)

    product = user_to_notificate.products.first
    liker1.like! product
    liker2.like! product

    login_as user_to_notificate, scope: :user

    visit root_path

    user_to_notificate.notifications.each do |notification|
      element = page.find('#notifications.active').find("#notification_#{notification.id}.unread")
      element.should have_xpath("//img[@src=\"#{notification.sender.avatar.url(:thumb)}\"]")
      element.find('.user-name').should have_content(notification.sender.first_name)
      element.should have_xpath("//a[@href=\"#{my_notification_path(notification)}\"]")
    end
  end

  it "should mark notification as read when visited" do
    liker1 = FactoryGirl.create(:user)
    user_to_notificate = FactoryGirl.create(:user_with_products, products_count: 2)

    product = user_to_notificate.products.first

    liker1.like! product

    login_as user_to_notificate, scope: :user

    visit my_notification_path(user_to_notificate.notifications.first)

    user_to_notificate.notifications.each do |notification|
      page.find('#notifications').should_not have_css("#notification_#{notification.id}.unread")
      page.find('#notifications').should have_css("#notification_#{notification.id}")
    end
  end
end
