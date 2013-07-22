class My::AttachmentsController < ApplicationController
  before_filter :authenticate_user!
  layout 'my'
  load_and_authorize_resource

  def destroy
    @attachment.destroy
    render json: @attachment
  end
end
