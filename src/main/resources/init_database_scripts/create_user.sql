USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [groceryadmin]    Script Date: 5/19/2021 1:44:29 PM ******/
CREATE LOGIN [groceryadmin] WITH PASSWORD=N'P@ssw0rd!', DEFAULT_DATABASE=[GroceryStore], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

--ALTER LOGIN [groceryadmin] DISABLE
GO


USE [GroceryStore]
GO

/****** Object:  User [groceryadmin]    Script Date: 5/19/2021 1:43:33 PM ******/
CREATE USER [groceryadmin] FOR LOGIN [groceryadmin] WITH DEFAULT_SCHEMA=[grocery]
GO


EXEC sp_addrolemember N'db_owner', N'groceryadmin'

GO