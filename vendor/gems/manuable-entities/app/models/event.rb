class Event < ActiveRecord::Base
  # attr_accessible :slug, :benefits, :notes, :attachments_attributes, :address, :cover, :location_map, :location_name, :name, :spaces, :price, :description, :event_schedules_attributes, :event_products_attributes, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time, :event_sale_categories_attributes, :lat, :lng, :city_id, :location, :phone, :zip, :user_ids, :requirements, :artisan_ids, :info_for_accepted_users

  has_many :event_products
  has_many :event_sale_categories
  has_many :event_payments
  # has_many :artisans, through: :event_payments, source: :user, conditions: { event_payments: { paid: true } }
  has_many :artisans, through: :event_requests, source: :user do
    def accepted
      where({ event_requests: { accepted: true } })
    end
  end
  has_many :event_requests
  has_many :event_schedules
  has_many :event_schedule_categories
  has_many :attachments, as: :attachable, dependent: :destroy
  has_and_belongs_to_many :users
  belongs_to :city
  belongs_to :author, foreign_key: :user_id, class_name: 'User'

  validates :spaces, numericality: { greater_than: 0 }, presence: true
  validates :name, :address, :location, :zip, :city, presence: true
  validates_with UserEventSlugValidator

  mount_uploader :cover, CoverUploader
  mount_uploader :location_map, EventLocationMapUploader

  accepts_nested_attributes_for :event_products, reject_if: proc {|attrs| attrs['name'].blank? || attrs[:price].blank? }
  accepts_nested_attributes_for :event_sale_categories, reject_if: proc {|attrs| attrs['name'].blank? || attrs[:price].blank? }
  accepts_nested_attributes_for :attachments, reject_if: proc{ |at| at[:attachment].blank? }
  accepts_nested_attributes_for :event_schedules, reject_if: proc{ |at| at[:name].blank? }

  before_validation :build_times
  before_validation :set_spaces

  scope :incoming, lambda { where { starts_at >= Date.today } }
  scope :banner, lambda { includes(city: :state) }
  scope :paid, lambda { where(paid: true) }

  def seats_left?
    seats_left > 0
  end

  def seats_left
    spaces - event_payments.where(paid: true).count
  end

  def generate_payments params, current_user
    ep = EventPayment.new
    ep.event_price = price
    ep.event_id = id
    ep.event_sale_category_id = params[:event_sale_category]
    ep.user_id = current_user.id
    gt = ep.event_sale_category.price
    (params[:event_products]||[]).each do |item_id, amount|
      item_id = item_id.to_i
      amount = amount.to_i
      epp = ep.event_product_payments.build
      epp.event_product_id = item_id
      epp.event_id = id
      epp.user_id = current_user.id
      epp.units = amount
      epp.unit_price = event_products.detect {|x| x.id == item_id }.price
      epp.total = amount * epp.unit_price
      gt += epp.total
    end
    ep.grand_total = gt
    ep
  end

  def starts_at_date=(sdate)
    @starts_at_date = sdate
  end

  def starts_at_time=(stime)
    @starts_at_time = stime
  end

  def ends_at_date=(sdate)
    @ends_at_date = sdate
  end

  def ends_at_time=(stime)
    @ends_at_time = stime
  end

  def starts_at_date
    if starts_at.present?
      starts_at.to_date
    else
      DateTime.now.to_date.to_s('%Y-%m-%d')
    end
  end

  def starts_at_time
    if starts_at.present?
      starts_at.strftime('%I:%M %p')
    else
      DateTime.now.strftime('%I:%M %p')
    end
  end

  def ends_at_date
    if ends_at.present?
      ends_at.to_date
    else
      (DateTime.now + 1.day).to_date.strftime('%Y-%m-%d')
    end
  end

  def ends_at_time
    if ends_at.present?
      ends_at.strftime('%I:%M %p')
    else
      (DateTime.now + 1.day).strftime('%I:%M %p')
    end
  end

  def total
    case plan_id
    when 1, "1"
      80
    when 2, "2"
      160
    when 3, "3"
      240
    end
  end

  protected

  def set_spaces
    case plan_id
    when 1, "1"
      if read_attribute(:spaces).to_i > 15
        write_attribute :spaces, 15
      end
    when 2, "2"
      if read_attribute(:spaces).to_i > 50
        write_attribute :spaces, 50
      end
    when 3, "3"
      if read_attribute(:spaces).to_i > 100
        write_attribute :spaces, 100
      end
    end
  end

  def build_times
    write_attribute :starts_at, self.string_to_datetime("#{@starts_at_date} #{@starts_at_time}", '%Y-%m-%d %I:%M %p') if @starts_at_date.present? && @starts_at_time.present?
    write_attribute :ends_at, self.string_to_datetime("#{@ends_at_date} #{@ends_at_time}", '%Y-%m-%d %I:%M %p') if @ends_at_date.present? && @ends_at_time.present?
  end

  def string_to_datetime(value, format)
    return value unless value.is_a?(String)

    begin
      Time.zone.parse(value)
    rescue ArgumentError
      nil
    end
  end
end
