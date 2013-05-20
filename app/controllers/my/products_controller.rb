class My::ProductsController < ApplicationController
  layout 'my'
  load_and_authorize_resource

  def index
    @my_section = "products"
    @products = current_user.products.page params[:page]
  end

  def new
    @my_section = "new_product"
    @product = current_user.products.new(params[:product])
    if @product.on_sale?
      if @product.attachments.length < 4
        (4 - @product.attachments.length).times { @product.attachments.build }
      end
    else
      @product.attachments.build if @product.attachments.length == 0
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    if @product.save
      # if params[:editing] == "1"
      #   @product.attachments.build
      #   redirect_to edit_my_product_path(@product)
      # else
      # @product.create_activity :create, owner: current_user
      redirect_to my_products_path
      # end
    else
      redirect_to :back
    end
  end

  def edit
    if @product.attachments.length < 4
      (4 - @product.attachments.length).times { @product.attachments.build }
    end
  end

  def update
    @product = current_user.products.find(params[:id])

    if !params[:product][:attachments_attributes].nil? && ( request.xhr? || params[:ajax_upload].present?)
      attachments_attributes = {}
      params[:product][:attachments_attributes].each do |k, v|

        attachments_attributes[ k ] = {}
        attachments_attributes[ k ]["_destroy"] = 'false'

        if v[:attachment].is_a? Array
          attachments_attributes[ k ][:attachment] = v[:attachment].first
        else
          attachments_attributes[ k ][:attachment] = v
        end
      end
      params[:product][:attachments_attributes] = attachments_attributes

      @product.update_attributes(params[:product])

      redirect_to edit_my_product_path(@product)
    else
      @product.update_attributes(params[:product])
      redirect_to edit_my_product_path(@product)
    end


    # @product.create_activity :update, owner: current_user

  end

  def destroy
    @product.destroy
    redirect_to :back
  end
end
