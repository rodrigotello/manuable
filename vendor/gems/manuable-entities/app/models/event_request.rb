# encoding: utf-8
class EventRequest < ActiveRecord::Base
  # attr_accessible :event_id, :user_id
  belongs_to :event
  belongs_to :user

  # after_create :notify_organizers
  validate :validate_plan

  scope :accepted, lambda {
    where(accepted: true)
  }
  private

  def validate_plan
    errors.add(:base, "Alcanzó límite del plan") if event.event_requests.accepted.count >= event.spaces
  end

  def notify_acceptance
    if accepted_changed? && accepted
    end
  end
end
