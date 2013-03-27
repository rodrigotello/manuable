class Product < ActiveRecord::Base
  attr_accessible :about, :available_at, :delivery_method, :depth, :factoring_time, :height, :how_is_done, :made_by, :name, :on_demand, :price, :usage, :weight, :what_it_is, :width, :available_items, :attachments_attributes

  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  # validates :delivery_method, inclusion: { in: [ 'pickup', 'packaging' ] }
  # validates :made_by, inclusion: { in: [ 'me', 'store' ] }
  # validates :name, :price, :user_id, presence: true

  accepts_nested_attributes_for :attachments
end
