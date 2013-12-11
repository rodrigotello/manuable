class EventSchedule < ActiveRecord::Base
  attr_accessible :ends_at, :event_schedule_category_id, :name, :starts_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time

  belongs_to :event
  belongs_to :event_schedule_category
  default_scope order('event_schedules.starts_at ASC')
  before_validation :build_times

  validates :ends_at, :starts_at, presence: true
  def as_json options={}
    {
      id: id,
      name: name,
      starts_at: I18n.l(starts_at, format: :time)
    }
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
      Time.zone.parse(value)
    rescue ArgumentError
      nil
    end
  end
end
