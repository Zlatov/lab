-- 1.   Установить расширение pgcrypto ...
-- 2.   Изменить схему БД выполнив команды из-под пользователя с привилегиями postgres:
--      ```
--          sudo -u postgres psql
--          \c lab;
--          CREATE EXTENSION pgcrypto;
--      ```

SELECT gen_random_uuid();
