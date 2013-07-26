class EventPayment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :event_sale_category
  has_many :event_product_payments

  validates :user_id, :event_id, :event_sale_category_id, presence: true
end
