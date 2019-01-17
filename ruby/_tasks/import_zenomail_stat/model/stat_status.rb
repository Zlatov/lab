class StatStatus < Base

  DELIVERED_NAME = 'Доставлено.'
  UNDELIVERED_WITHOUT_REASON_NAME = 'Не доставлено по неизвестной причине.'

  has_many :stat_relays,
    foreign_key: :status_id

  def self.new args
    obj = super
    obj.name = DELIVERED_NAME if args[:delivered]
    obj.name = UNDELIVERED_WITHOUT_REASON_NAME if !args[:delivered] && args[:code].nil?
    obj
  end
end
