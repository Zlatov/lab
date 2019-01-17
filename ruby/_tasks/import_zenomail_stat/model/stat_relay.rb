class StatRelay < Base
  belongs_to :stat_date,
    foreign_key: :date_id
  belongs_to :stat_email,
    foreign_key: :email_id
  belongs_to :stat_status,
    foreign_key: :status_id
  belongs_to :stat_label,
    foreign_key: :label_id

  # def self.reimport_zenomailstat date, stat
  #   clear_by_date date
  #   import_zenomailstat date, stat
  # end

  # def self.clear_by_date date
  #   d = StatDate.find_by_date date
  #   if !d.nil?
  #     puts "find date!".green
  #     delete_all date_id: d.id
  #   end
  # end

  def self.import_zenomailstat date, stat
    d = StatDate.find_by_date(date) || StatDate.new(date: date)
    for h in stat
      e = StatEmail.find_by_email(h[:email]) ||
          StatEmail.new(email: h[:email])
      s = StatStatus.where(delivered: h[:delivered], code: h[:code]).first ||
          StatStatus.new(
            delivered: h[:delivered],
            code: h[:code],
            name: h[:message]
          )
      l = h[:label].nil? ? StatLabel.find_without_label : (StatLabel.find_by_label(h[:label]) || StatLabel.new(h[:label]))
      c = h[:count]

      if d.new_record? && !d.valid?
        raise "Date not valid."
      end
      if e.new_record? && !e.valid?
        raise "Email not valid."
      end
      if s.new_record? && !s.valid?
        raise "Status not valid."
      end
      if l.new_record? && !l.valid?
        raise "Label not valid."
      end

      d.save if d.new_record?
      e.save if e.new_record?
      s.save if s.new_record?
      l.save if l.new_record?

      r = {
        date_id: d.id,
        email_id: e.id,
        status_id: s.id,
        label_id: l.id
      }

      r = where(
        date_id: d.id,
        email_id: e.id,
        status_id: s.id,
        label_id: l.id
      ).first || new(
        date_id: d.id,
        email_id: e.id,
        status_id: s.id,
        label_id: l.id,
        count: c
      )
      if r.new_record?
        r.valid? && r.save
      else
        r.update(count: c)
      end
    end
  end
end
