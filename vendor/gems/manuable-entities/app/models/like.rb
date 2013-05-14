class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :user_id, uniqueness: { scope: :product_id }

  def as_json options={}
    {}
  end
end
