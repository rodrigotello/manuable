class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :attachment
  belongs_to :attachable

  mount_uploader :attachment, AttachUploader

  def ajax_uploader_data
    {
      name: attachment.identifier,
      size: attachment.size,
      url: attachment.url,
      thumbnail_url: attachment.url(:thumb),
      delete_url: attachment.url(:thumb),
      delete_type: "DELETE"
    }
  end
end
