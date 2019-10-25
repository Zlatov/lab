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

-- Очистить
TRUNCATE TABLE dbo.Market_1c_order;
