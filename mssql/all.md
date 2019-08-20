# MSSQL

## Установка SQL Server

```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list | sudo tee /etc/apt/sources.list.d/mssql-server-2017.list
sudo apt-get update
sudo apt-get install mssql-server
sudo /opt/mssql/bin/mssql-conf setup
```

```
sudo service mssql-server start
systemctl status mssql-server
```

```
SELECT name FROM master.sys.databases
EXEC sp_databases
```

## Установка программ командной строки SQL Server
```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update 
sudo apt-get install mssql-tools unixodbc-dev
sudo apt-get update 
sudo apt-get install mssql-tools
```

## Использование

`sqlcmd -S localhost -U SA -P '<YourPassword>'`


SELECT @@VERSION AS 'SQL Server Version';

GO
