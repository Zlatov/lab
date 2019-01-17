class StatDate < Base
  has_many :stat_relays,
    foreign_key: :date_id

  validates :date, presence: true, allow_blank: false
end
