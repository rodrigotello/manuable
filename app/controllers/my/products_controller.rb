class My::ProductsController < ApplicationController
  before_filter :authenticate_user!
  layout 'my'
  load_and_authorize_resource

  def index
    @my_section = "products"
    @products = current_user.products.page params[:page]
  end

  def new
    @my_section = "new_product"
    @product = current_user.products.new(params[:product])
    if @product.attachments.length < 4
      (4 - @product.attachments.length).times { @product.attachments.build }
    end

  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    if @product.attachments.length < 4
      (4 - @product.attachments.length).times { @product.attachments.build }
    end
    if @product.save
      redirect_to @product
    else
      render action: :new
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
