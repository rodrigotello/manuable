require 'spec_helper'

describe 'like product' do

  it 'unlike product check' do
    sign_in_as_a_user
    user = FactoryGirl.create(:user_with_products, products_count: 6)
    product = user.products.first

    visit root_path

    page.should_not have_css("#heart-overlay-product_#{product.id}.liked")
    assert page.find("#heart-overlay-product_#{product.id} .likes-count").has_content?("0"), 'like count'

  end

  it 'liked product counter' do
    # js driver not working well
    sign_in_as_a_user
    user = FactoryGirl.create(:user_with_products, products_count: 6)
    product = user.products.first
    product.like! @current_user
    product.like! user
    visit root_path

    page.should have_css("#heart-overlay-product_#{product.id}.liked")

    assert !page.find("#heart-overlay-product_#{product.id} .likes-count").has_content?("1"), 'like increment'
    assert page.find("#heart-overlay-product_#{product.id} .likes-count").has_content?("2"), 'like increment'
  end

end
