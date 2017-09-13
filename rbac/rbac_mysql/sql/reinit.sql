source /home/iadfeshchm/projects/my/lab/lab/rbac/rbac_mysql/sql/recreate_schema.sql;
USE lab;
source /home/iadfeshchm/projects/my/lab/lab/rbac/rbac_mysql/sql/recreate_tables.sql;
source /home/iadfeshchm/projects/my/lab/lab/rbac/rbac_mysql/sql/recreate_procedures.sql;
source /home/iadfeshchm/projects/my/lab/lab/rbac/rbac_mysql/sql/recreate_triggers.sql;

CALL add_user('Златов');    -- 1
CALL add_user('Иванов');    -- 2
CALL add_user('Петров');    -- 3
CALL add_user('Сарнычева'); -- 4
CALL add_user('Сидоров');   -- 5
CALL add_user('Гринина');   -- 6
CALL add_user('Огаркова');  -- 7
CALL add_user('Пастух');    -- 8
CALL add_user('Вергунова'); -- 9
CALL add_user('Нилов');     -- 10
CALL add_user('Моргунов');  -- 11
CALL add_user('Носатенко'); -- 12

CALL add_obj(NULL, 'ЦСП',      'csp'              ); -- 1
CALL add_obj(1,    'Каталог',  'csp_catalog'      ); -- 2
CALL add_obj(2,    'Seo',      'csp_catalog_seo'  ); -- 3
CALL add_obj(1,    'Продукт',  'csp_product'      ); -- 4
CALL add_obj(4,    'Seo',      'csp_product_seo'  ); -- 5
CALL add_obj(NULL, 'ВИПС',     'vips'             ); -- 6
CALL add_obj(6,    'Каталог',  'vips_catalog'     ); -- 7
CALL add_obj(7,    'Seo',      'vips_catalog_seo' ); -- 8
CALL add_obj(6,    'Продукт',  'vips_product'     ); -- 9
CALL add_obj(9,    'Seo',      'vips_product_seo' ); -- 10
CALL add_obj(NULL, 'Филиалы',  'affiliates'       ); -- 11
CALL add_obj(11,   'Seo',      'affiliates_seo'   ); -- 12

CALL add_role('новый менеджер проекта ВИПС');   -- 1
CALL add_role('новый менеджер проекта ЦСП');    -- 2
CALL add_role('Младший менеджер проекта ЦСП');  -- 3
CALL add_role('Менеджер проекта ВИПС');         -- 4
CALL add_role('Менеджер проекта ЦСП');          -- 5
CALL add_role('Старший менеджер проекта ВИПС'); -- 6
CALL add_role('Старший менеджер проекта ЦСП');  -- 7
CALL add_role('Руководитель проекта ВИПС');     -- 8
CALL add_role('Руководитель проекта ЦСП');      -- 9
CALL add_role('Директор');                      -- 10
CALL add_role('Seo специалист');                -- 11
CALL add_role('Администратор');                 -- 12

CALL add_perm('read', 'Читать');   -- 1
CALL add_perm('edit', 'Изменять'); -- 2


CALL set_role_parent(4,1);
CALL set_role_parent(3,2);
CALL set_role_parent(5,3);
CALL set_role_parent(6,4);
CALL set_role_parent(7,5);
CALL set_role_parent(8,6);
CALL set_role_parent(9,7);
CALL set_role_parent(10,8);
CALL set_role_parent(10,9);
CALL set_role_parent(12,10);
CALL set_role_parent(12,11);

CALL set_rpo(1, 1, 1);
CALL set_rpo(1, 2, 1);
CALL set_rpo(1, 1, 6);
CALL set_rpo(1, 2, 6);
CALL set_rpo(1, 1, 11);
CALL set_rpo(1, 2, 11);
CALL set_rpo(2, 1, 1);
CALL set_rpo(2, 2, 1);
CALL set_rpo(2, 1, 6);
CALL set_rpo(2, 2, 6);
CALL set_rpo(2, 1, 11);
CALL set_rpo(2, 2, 11);
CALL set_rpo(11, 1, 3);
CALL set_rpo(11, 1, 5);
CALL set_rpo(11, 1, 8);
CALL set_rpo(11, 1, 10);
CALL set_rpo(11, 1, 12);
CALL set_rpo(11, 2, 3);
CALL set_rpo(11, 2, 5);
CALL set_rpo(11, 2, 8);
CALL set_rpo(11, 2, 10);
CALL set_rpo(11, 2, 12);

CALL set_user_role(1,12);
CALL set_user_role(2,11);
CALL set_user_role(3,10);
CALL set_user_role(4,9);
CALL set_user_role(5,8);
CALL set_user_role(6,7);
CALL set_user_role(7,6);
CALL set_user_role(8,5);
CALL set_user_role(9,4);
CALL set_user_role(10,3);
CALL set_user_role(11,2);
CALL set_user_role(12,1);
