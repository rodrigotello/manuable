class My::ProductsController < ApplicationController
  layout 'my'
  load_and_authorize_resource

  def new
    @my_section = "new_product"
    @product = current_user.products.new
  end

  def initial
    @product = Product.new
    #@product.attachments.build
    #@product = current_user.products.create
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    if @product.save
      redirect_to my_product_characteristics_path(@product.id)
    else
      render 'index'
    end
  end

  def characteristics
    @product = Product.find(params[:product_id])
  end

  def attach
    @product = Product.find(params[:product_id])
  end

  def index
    @my_section = "products"
    @products = current_user.products.page params[:page]
  end

  def edit
    # @product = current_user.products.find(params[:id])
  end

  def update
    if !params[:product][:attachments_attributes].nil?
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
      redirect_to my_product_path(@product.id)
    else
      @product = current_user.products.find(params[:id])
      @product.update_attributes(params[:product])
      redirect_to my_product_attach_path(@product.id)
    end
  end

  def destroy
    @product.destroy
    redirect_to :back
  end
end
