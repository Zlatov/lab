class StatLabel < Base
  LABEL_WITHOUT_LABEL = 'Without label.'

  has_many :stat_relays,
    foreign_key: :label_id

  def self.find_without_label
    find_by_label LABEL_WITHOUT_LABEL
  end
end
