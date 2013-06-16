require 'spec_helper'

describe 'products' do

  it 'show product feed view' do
    sign_in_as_a_user
    user = FactoryGirl.create(:user_with_products, products_count: 6)

    visit root_path()
    # take_screenshot

    user.products.order('products.created_at DESC').take(5).each do |p|
      product_node = find("#product_#{p.id}")
      product_node.find('.product-name').should have_content(p.name)
      product_node.find('.product-about').should have_content(p.about)

      p.prop_list.each do |t|
        product_node.find('.product-tags').should have_xpath("//a[@href=\"/?tag=#{t}\"]")
      end
      # product_node.find('.product-picture').should have_css('img', text: p.attachments.first.attachment.url(:xlarge))
      product_node.find('.product-picture').should have_xpath("//img[@src=\"#{p.attachments.first.attachment.url(:xlarge)}\"]")
      product_node.find('.user-avatar').should  have_xpath("//img[@src=\"#{p.user.avatar.url(:small)}\"]")
    end
  end

  it "should filter products by tags" do
    sign_in_as_a_user
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)

    FactoryGirl.create(:product, user: user1, prop_list: ['hechoamano', 'mexicano', 'madera', ])
    FactoryGirl.create(:product, user: user1, prop_list: ['decoracion', 'cocina', 'dibujo', ])
    FactoryGirl.create(:product, user: user1, prop_list: ['poster', 'joyas', 'joyeria'])

    FactoryGirl.create(:product, user: user2, prop_list: ['hechoamano', 'mexicano', 'madera', ])
    FactoryGirl.create(:product, user: user2, prop_list: ['decoracion', 'cocina', 'dibujo', ])
    FactoryGirl.create(:product, user: user2, prop_list: ['poster', 'joyas', 'joyeria'])

    FactoryGirl.create(:product, user: user3, prop_list: ['hechoamano', 'mexicano', 'madera', ])
    FactoryGirl.create(:product, user: user3, prop_list: ['decoracion', 'cocina', 'dibujo', ])
    FactoryGirl.create(:product, user: user3, prop_list: ['poster', 'joyas', 'joyeria'])

    visit "/?tags=hechoamano&per_page=10"

    page.should have_css('.activity', count: 3)

    page.all(:css, '.activity').each do |ele|
      ele.should have_xpath("//a[@href=\"/?tag=hechoamano\"]")
    end

  end

end
