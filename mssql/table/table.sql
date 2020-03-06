-- Удалить
DROP TABLE IF EXISTS [dbo].[Market_1c_order]
GO

-- Создать
CREATE TABLE [dbo].[Market_1c_order] (
 [id] INT NOT NULL,
 [order_data] NVARCHAR(MAX) NOT NULL,
 [status] SMALLINT NOT NULL
 PRIMARY KEY ([id])
)
GO

DROP TABLE [dbo].[temp_Market_1c_order]
GO
CREATE TABLE [dbo].[temp_Market_1c_order] (
  [id] INT NOT NULL,
  [order_data] NVARCHAR(MAX) NOT NULL,
  [status] SMALLINT NOT NULL,
  [is_changed] BIT NOT NULL DEFAULT 0,
  [order_data_1c] NVARCHAR(MAX),
  PRIMARY KEY (id)
)
GO
CREATE INDEX ix_temp_Market_1c_order_status ON [dbo].[temp_Market_1c_order](status)
CREATE INDEX ix_temp_Market_1c_order_ischanged ON [dbo].[temp_Market_1c_order](is_changed)
GO

-- Очистить
TRUNCATE TABLE dbo.Market_1c_order
GO

-- Добавить поле
ALTER TABLE [dbo].[staging_zlatov_Market_1c_order]
ADD [order_data_1c] NVARCHAR(MAX)
GO

-- Изменить поле
ALTER TABLE dbo.temp_Market_1c_order ADD CONSTRAINT cd_temp_Market_1c_order_isdefault DEFAULT 0 FOR is_changed
UPDATE dbo.temp_Market_1c_order SET is_changed = 0
ALTER TABLE dbo.temp_Market_1c_order ALTER COLUMN is_changed BIT NOT NULL
