class My::ProductsController < ApplicationController
  layout 'my'

  def new
    @my_section = "new_product"
    @product = current_user.products.create
    @product.attachments.build
  end

  def index
    @my_section = "products"
    @products = current_user.products
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    attachments_attributes = {}
    params[:product][:attachments_attributes].each do |k, v|
      i = attachments_attributes.length + 1

      attachments_attributes[ i ] = {}
      attachments_attributes[ i ]["_destroy"] = 'false'

      if v[:attachment].is_a? Array
        attachments_attributes[ i ][:attachment] = v[:attachment].first
      else
        attachments_attributes[ i ][:attachment] = v
      end
    end

    params[:product][:attachments_attributes] = attachments_attributes

    @product = current_user.products.find(params[:id])
    @product.update_attributes(params[:product])

    render json: [@product.attachments.collect(&:ajax_uploader_data)]
  end
end
