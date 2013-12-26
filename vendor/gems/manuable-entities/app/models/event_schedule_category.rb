class EventScheduleCategory < ActiveRecord::Base
  # attr_accessible :event_id, :name
  has_many :event_schedules
  belongs_to :event

end
