class My::AttachmentsController < ApplicationController
  layout 'my'
  load_and_authorize_resource

  def destroy
    @attachment.destroy
    render json: @attachment
  end
end
