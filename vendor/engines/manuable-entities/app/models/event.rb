class Event < ActiveRecord::Base
  attr_accessible :address, :cover, :name, :spaces, :price, :description, :event_products_attributes, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time

  has_many :event_products

  validates :spaces, numericality: { greater_than: 0 }, presence: true
  validates :name, :price, :address, presence: true

  accepts_nested_attributes_for :event_products, reject_if: proc {|attrs| attrs['name'].blank? }

  before_validation :build_times

  def generate_payments params, current_user
    ep = EventPayment.new
    ep.event_price = price
    ep.event_id = id
    ep.user_id = current_user.id
    gt = price
    params[:event_products].each do |item_id, amount|
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

  protected

  def build_times
    write_attribute :starts_at, self.string_to_datetime("#{@starts_at_date} #{@starts_at_time}", '%Y-%m-%d %I:%M %p') if @starts_at_date.present? && @starts_at_time.present?
    write_attribute :ends_at, self.string_to_datetime("#{@ends_at_date} #{@ends_at_time}", '%Y-%m-%d %I:%M %p') if @ends_at_date.present? && @ends_at_time.present?
  end

  def string_to_datetime(value, format)
    return value unless value.is_a?(String)

    begin
      DateTime.strptime(value, format)
    rescue ArgumentError
      nil
    end
  end
end
