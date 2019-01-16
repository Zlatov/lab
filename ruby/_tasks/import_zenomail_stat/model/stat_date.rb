class StatDate < Base
  has_many :stat_relays,
    foreign_key: :date_id
end
