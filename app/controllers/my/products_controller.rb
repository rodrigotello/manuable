class My::ProductsController < ApplicationController
  before_filter :authenticate_user!
  layout 'my'
  # load_and_authorize_resource

  def index
    @my_section = "products"
    @products = current_user.products.page params[:page]
  end

  def new
    @my_section = "new_product"
    @product = current_user.products.new
    if @product.attachments.length < 4
      (4 - @product.attachments.length).times { @product.attachments.build }
    end

  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    @product.user_id = current_user.id

    if @product.save
      redirect_to my_products_path
    else
      if @product.attachments.length < 4
        (4 - @product.attachments.length).times { @product.attachments.build }
      end
      render action: :new
    end
  end

  def edit
    @product = current_user.products.find params[:id]
    if @product.attachments.length < 4
      (4 - @product.attachments.length).times { @product.attachments.build }
    end
  end

  def update
    @product = current_user.products.find(params[:id])
    pp = product_params
    if !pp[:attachments_attributes].nil? && ( request.xhr? || params[:ajax_upload].present?)
      attachments_attributes = {}
      pp[:attachments_attributes].each do |k, v|

        attachments_attributes[ k ] = {}
        attachments_attributes[ k ]["_destroy"] = 'false'

        if v[:attachment].is_a? Array
          attachments_attributes[ k ][:attachment] = v[:attachment].first
        else
          attachments_attributes[ k ][:attachment] = v
        end
      end
      pp[:attachments_attributes] = attachments_attributes

      @product.update_attributes(pp)

      redirect_to edit_my_product_path(@product)
    else
      @product.update_attributes(pp)
      redirect_to edit_my_product_path(@product)
    end


    # @product.create_activity :update, owner: current_user

  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:about, :made_by, :name, :shipping, :price, { :attachments_attributes => [:attachment, :_destroy, :id, :attachable_type, :attachable_id] }, :category_id, :on_sale, :amount, :prop_list)
  end
end
