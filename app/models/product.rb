class Product < ActiveRecord::Base
  attr_accessible :about, :made_by, :name, :price,
                  :attachments_attributes, :category_id, :on_sale, :amount, :materials

  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  belongs_to :category

  accepts_nested_attributes_for :attachments, reject_if: proc{ |at| at[:attachment].blank? }
end
