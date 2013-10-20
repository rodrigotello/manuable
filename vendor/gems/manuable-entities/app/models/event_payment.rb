class EventPayment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :event_sale_category
  has_many :event_product_payments

  validates :user_id, :event_id, :event_sale_category_id, presence: true
  scope :not_expired_or_paid, lambda {
    where(["event_payments.oxxo_expires_on >= ? or event_payments.paid = true", Date.today])
  }
end
