class StatRelay < Base
  belongs_to :stat_date,
    foreign_key: :date_id
  belongs_to :stat_email,
    foreign_key: :email_id
  belongs_to :stat_status,
    foreign_key: :status_id
  belongs_to :stat_label,
    foreign_key: :label_id
end
