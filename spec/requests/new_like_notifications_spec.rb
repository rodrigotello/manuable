require 'spec_helper'

describe "LikeNotifications" do
  it "notifies the user about the like" do
    liker1 = FactoryGirl.create(:user)
    liker2 = FactoryGirl.create(:user)
    user_to_notificate = FactoryGirl.create(:user_with_products, products_count: 2)

    product = user_to_notificate.products.first
    liker1.like! product
    liker2.like! product

    login_as user_to_notificate, scope: :user

    visit root_path

    page.should have_css('#notifications_count.active')

    user_to_notificate.notifications.each do |notification|
      element = page.find('#notifications').find("#notification_#{notification.id}")
      element.should have_xpath("//img[@src=\"#{notification.sender.avatar.url(:small)}\"]")
      element.find('.user-name').should have_content(notification.sender.first_name)
      element.should have_xpath("//a[@href=\"#{product_path(notification.product)}\"]")
    end
  end
end
