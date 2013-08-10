class EventSchedule < ActiveRecord::Base
  attr_accessible :ends_at, :event_schedule_category_id, :name, :starts_at

  belongs_to :event
  belongs_to :event_schedule_category

  def as_json options={}
    {
      id: id,
      name: name,
      starts_at: I18n.l(starts_at, format: :time)
    }
  end
end
