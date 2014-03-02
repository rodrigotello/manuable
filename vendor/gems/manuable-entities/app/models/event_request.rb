# encoding: utf-8
class EventRequest < ActiveRecord::Base
  # attr_accessible :event_id, :user_id
  belongs_to :event, inverse_of: :event_requests
  belongs_to :user

  validate :validate_plan

  scope :accepted, lambda {
    where(accepted: true)
  }
  after_create :notify_organizers
  before_update :notify_acceptance

  private

  def validate_plan
    errors.add(:base, "Alcanzó límite del plan") if event.event_requests.accepted.count >= event.spaces
  end

  def notify_acceptance
    if accepted_changed? && accepted
    end
  end

  def notify_organizers
    event.users.each do |u|
      UserMailer.new_event_request(self, u).deliver
    end
  end

  def notify_acceptance
    if accepted_changed? && accepted
      UserMailer.event_request_accepted(self).deliver
    end
    true
  end
end
