class Attachment < ActiveRecord::Base
  # attr_accessible :attachable_id, :attachable_type, :attachment
  belongs_to :attachable, polymorphic: true, counter_cache: true

  scope :random, order("RANDOM()")
  mount_uploader :attachment, AttachUploader
  include Rails.application.routes.url_helpers
  validates :attachment, presence: true
  # validate :attachment_count
  # after_save :cache_if_avail

  def as_json options={}
    {
      id: id,
      name: attachment.identifier,
      attachable_type: attachable_type,
      attachable_id: attachable_id,
      size: attachment.size,
      url: attachment.url,
      thumbnail_url: attachment.url(:thumb),
      delete_url: polymorphic_path([self.attachable, self])
    }
  end


end
