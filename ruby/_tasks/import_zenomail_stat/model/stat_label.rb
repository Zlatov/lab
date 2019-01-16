class StatLabel < Base
  has_many :stat_relays,
    foreign_key: :label_id
end
