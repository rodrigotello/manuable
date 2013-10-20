class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :product, counter_cache: true

  validates :user_id, uniqueness: { scope: :product_id }

  after_create :notify_product_owner

  def as_json options={}
    {}
  end

  private

  def notify_product_owner
    product.user.notifications.create! from_id: user.id, code: 'liked', product_id: product_id
  end
end
