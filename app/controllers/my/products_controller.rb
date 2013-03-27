class My::ProductsController < ApplicationController
  layout 'my'

  def new
    @my_section = "new_product"
    @product = current_user.products.create
  end

  def index
    @my_section = "products"
    @products = current_user.products
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    attachments_attributes = []
    params[:product][:attachments_attributes].each do |k, v|
      if v[:attachment].is_a? Array
        attachments_attributes[attachments_attributes.length*1][(rand*100000000).to_i] = v[:attachment].first
      else
        attachments_attributes[k] = v
      end
    end

    params[:product][:attachments_attributes] = attachments_attributes

    @product = current_user.products.create(params[:product])
    render json: [@product.attachments.collect(&:ajax_uploader_data)]
  end
end
