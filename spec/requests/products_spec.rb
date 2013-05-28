require 'spec_helper'

describe 'products' do

  it 'show product feed view' do
    sign_in_as_a_user
    user = FactoryGirl.create(:user_with_products, products_count: 6)

    assert_equal user.products.count, 6, 'fail'

    visit root_path()
    # take_screenshot

    user.products.take(5).each do |p|
      product_node = find("#product_#{p.id}")
      product_node.find('.product-name').should have_content(p.name)
      product_node.find('.product-about').should have_content(p.about)
      product_node.find('.product-tags').should have_content(p.prop_list.map{|t|"##{t}"}.join(', '))
      # product_node.find('.product-picture').should have_css('img', text: p.attachments.first.attachment.url(:xlarge))
      product_node.find('.product-picture').should have_xpath("//img[@src=\"#{p.attachments.first.attachment.url(:xlarge)}\"]")
      product_node.find('.user-avatar a').should  have_xpath("//img[@src=\"#{p.user.avatar.url(:small)}\"]")
    end
  end


end
