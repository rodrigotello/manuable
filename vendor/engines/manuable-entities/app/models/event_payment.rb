class EventPayment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :event_product_payments
end
