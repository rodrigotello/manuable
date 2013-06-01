require 'spec_helper'
describe Like do
  it 'should notify product owner when his product is liked' do
    user = FactoryGirl.create(:user_with_products, products_count: 4)
    current_user = FactoryGirl.create(:user)
    product = user.products.first
    current_user.like! product

    user.notifications.unread.should have(1).record
    notification = user.notifications.first

    notification.product_id.should == product.id
    notification.to_id.should == user.id
    notification.from_id.should == current_user.id
    notification.code.should == 'liked'
    notification.should_not be_new_record

  end
end

