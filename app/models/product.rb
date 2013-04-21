class Product < ActiveRecord::Base
  attr_accessible :about, :made_by, :name, :price,
                  :attachments_attributes, :category_id, :on_sale, :amount, :prop_list
  acts_as_taggable_on :prop

  belongs_to :user
  belongs_to :category
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: proc{ |at| at[:attachment].blank? }, limit: 4

  def ready?
    name.present? && attachments.count > 0 && category.present?
  end
end
