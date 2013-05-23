class Product < ActiveRecord::Base

  attr_accessible :about, :made_by, :name, :price,
                  :attachments_attributes, :category_id, :on_sale, :amount, :prop_list
  acts_as_taggable_on :prop

  belongs_to :user
  belongs_to :category
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :like, source: :user

  accepts_nested_attributes_for :attachments, reject_if: proc{ |at| at[:attachment].blank? }, limit: 4

  mount_uploader :attachment, AttachUploader # caching purpose

  scope :feed, lambda { |u|
    if u.present?
      joins("LEFT OUTER JOIN likes ON likes.product_id = products.id AND likes.user_id = #{u.id}")
      .select("products.*, coalesce(likes.id, 0) AS liked")
      .includes([{user: [:city, :state]}, :category, :prop, :attachments])
    else
      includes([{user: [:city, :state]}, :category, :prop, :attachments])
    end
  }
  scope :recently_created, order('products.created_at DESC')
  scope :liked_by, lambda { |id_or_ids_or_record|
    if id_or_ids_or_record.is_a? user
      where(id: user.id)
    else
      where(id: user.id)
    end

  }

  def ready?
    name.present? && attachments.count > 0 && category.present?
  end

  def like! current_user
    likes.where(user_id: current_user.id).first_or_create
  end

end
