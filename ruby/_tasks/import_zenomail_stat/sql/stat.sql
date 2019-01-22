\c zenon_production;

SELECT
  *
FROM admin_stat_relays r
INNER JOIN admin_stat_dates d ON d.id = r.date_id;
