class Product < ActiveRecord::Base
  attr_accessible :about, :availability_items, :available_at, :delivery_method, :depth, :factoring_time, :height, :how_is_done, :made_by, :name, :on_demand, :price, :usage, :weight, :what_it_is, :width

  belongs_to :user

  validates :delivery_method, inclusion: { in: [ 'pickup', 'packaging' ] }
  validates :made_by, inclusion: { in: [ 'me', 'store' ] }
  validates :name, :price, :user_id, presence: true

end
