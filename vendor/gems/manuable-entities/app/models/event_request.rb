class EventRequest < ActiveRecord::Base
  # attr_accessible :event_id, :user_id
  belongs_to :event
  belongs_to :user

  after_create :notify_organizers
  before_save :notify_acceptance

  private

  def notify_organizers

  end

  def notify_acceptance
    if accepted_changed? && accepted
    end
  end
end
