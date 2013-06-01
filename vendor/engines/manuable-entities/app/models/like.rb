class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :product, counter_cache: true

  validates :user_id, uniqueness: { scope: :product_id }

  def as_json options={}
    {}
  end
end
