RailsAdmin.config do |config|
  config.authorize_with do
    redirect_to main_app.root_path unless  [7, 6, 13, 21, 10, 43].include?(warden.user.id)
  end
  config.excluded_models += %w{ Message State Commontator::Thread Commontator::Subscription Notification City AccessToken AdminUser Attachment Authentication EventPayment EventProduct EventProductPayment EventRequest EventSaleCategory EventSchedule EventScheduleCategory }
  config.excluded_models << "Commontator::Comment" #BUG
  config.excluded_models << "Conversation" # TODO

  config.model User do
    export do
      field :id
      field :name
      field :email
      field :city
      field :state
      field :birthday
      field :products_count
    end
    list do
      field :id
      field :name
      field :email
      field :city
      field :state
      field :products_count
    end
  end

  config.model Following do
    list do
      field :id
      field :follower
      field :followee
    end
  end

  config.model Product do
    list do
      field :id
      field :name
      field :user
      field :category
      field :likes_count
      field :price
      field :about
      field :amount
      field :attachments_count
      field :created_at
    end
  end

  config.model Like do
    list do
      field :id
      field :user
      field :product
      field :created_at
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
