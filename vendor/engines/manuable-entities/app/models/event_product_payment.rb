class EventProductPayment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :event_product
  belongs_to :event_payment
end
