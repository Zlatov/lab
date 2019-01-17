class Migration < ActiveRecord::Migration[5.0]
  def change
    create_table :stat_emails do |t|
      t.string :email, null: false, unique: true, :limit => 254
    end
    execute <<-SQL
      COMMENT ON TABLE stat_emails IS 'Все адреса по которым когда либо была произведена рассылка.';
      CREATE INDEX ix_statemails_email ON stat_emails (email);
      COMMENT ON INDEX ix_statemails_email IS 'Индекс для поиска по email.';
    SQL
    execute <<-SQL
      CREATE TABLE stat_dates (
        id smallserial PRIMARY KEY,
        "date" date NOT NULL UNIQUE
      );
      COMMENT ON TABLE stat_dates IS 'Все даты в которые проводилась рассылки хоть на какие-то адреса.';
    SQL
    create_table :stat_statuses, comment: "Все возможные статусы." do |t|
      t.boolean :delivered, null: false
      t.string  :code,      null: true, unique: true, :limit => 3
      t.string  :name,      null: false, :limit => 511
    end
    add_index :stat_statuses, [:delivered, :code], name: :uq_statstatuses_deliveredcode, unique: true
    create_table :stat_labels do |t|
      t.string :label, null: false, unique: true, :limit => 255
    end
    execute <<-SQL
      COMMENT ON TABLE stat_labels IS 'Все возможные метки для рассылок и остальнного.';
      INSERT INTO "stat_labels" ("label") VALUES ('Without label.');
    SQL
    execute <<-SQL
      CREATE TABLE stat_relays (
        date_id smallint NOT NULL REFERENCES stat_dates (id) ON DELETE RESTRICT ON UPDATE CASCADE,
        email_id integer NOT NULL REFERENCES stat_emails (id) ON DELETE RESTRICT ON UPDATE CASCADE,
        status_id integer NOT NULL REFERENCES stat_statuses (id) ON DELETE RESTRICT ON UPDATE CASCADE,
        label_id integer NOT NULL REFERENCES stat_labels (id) ON DELETE RESTRICT ON UPDATE CASCADE,
        count integer NOT NULL,
        CHECK (count > 0),
        UNIQUE (date_id, email_id, status_id, label_id)
      );
      COMMENT ON TABLE stat_relays IS 'Сводная таблица статистики по отправленным письмам.';
      COMMENT ON COLUMN stat_relays.count IS 'В один день может быть несколько сообщений с одним и тем жет адресом получателя, статусом и меткой.';
      CREATE INDEX ix_statstat_unique ON stat_relays (date_id, email_id, status_id, label_id);
    SQL
  end
end

Migration.new.change
