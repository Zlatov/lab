class StatStatus < Base
  has_many :stat_relays,
    foreign_key: :status_id
end
