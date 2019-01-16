class StatEmail < Base
  has_many :stat_relays,
    foreign_key: :email_id
end
