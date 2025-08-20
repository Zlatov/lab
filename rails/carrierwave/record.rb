class Record < ApplicationRecord
  mount_uploader :attachment, RecordAttachmentUploader

  validate :attachment_size_validation

  private

  def attachment_size_validation
    if attachment.present? && attachment.file.present?
      if attachment.file.size > 10.megabytes
        errors.add(:attachment, "должен быть меньше 10 МБ")
      end
    end
  end
end
