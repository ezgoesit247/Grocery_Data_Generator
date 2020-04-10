USE AdventureWorksDW2016


DROP TABLE IF EXISTS [datagen].[Sales]
DROP TABLE IF EXISTS [datagen].[DimProduct]
DROP TABLE IF EXISTS [datagen].[DimProductSubcategory]
DROP TABLE IF EXISTS [datagen].[DimProductCategory]
DROP TABLE IF EXISTS [datagen].[DimPromotion]
DROP TABLE IF EXISTS [datagen].[DimCurrency]
DROP TABLE IF EXISTS [datagen].[DimCustomer]
DROP TABLE IF EXISTS [datagen].[DimDate]
DROP TABLE IF EXISTS [datagen].[DimGeography]
DROP TABLE IF EXISTS [datagen].[DimSalesTerritory]


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE TABLE [datagen].[DimProductCategory](
	[ProductCategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKdatagen_DimProductCategory_ProductCategoryKey] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/*not inserting*/
--INSERT INTO [datagen].[DimProductCategory] ([ProductCategoryName]) VALUES
--('Beverages'),('Bread/Bakery'),('Canned/Jarred Goods'),('Dairy'),('Dry/Baking Goods'),('Frozen Foods'),
--('Meat'),('Produce'),('Cleaners'),('Paper Goods'),('Personal Care')	



CREATE TABLE [datagen].[DimProductSubcategory](
	[ProductSubcategoryKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductSubcategoryName] [nvarchar](50) NOT NULL,
	[ProductCategoryKey] [int] NULL,
 CONSTRAINT [PKdatagen_DimProductSubcategory_ProductSubcategoryKey] PRIMARY KEY CLUSTERED 
(
	[ProductSubcategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [datagen].[DimProductSubcategory]  WITH CHECK ADD  CONSTRAINT [FKdatagen_DimProductSubcategory_DimProductCategory] FOREIGN KEY([ProductCategoryKey])
REFERENCES [datagen].[DimProductCategory] ([ProductCategoryKey])
GO

ALTER TABLE [datagen].[DimProductSubcategory] CHECK CONSTRAINT [FKdatagen_DimProductSubcategory_DimProductCategory]
GO




CREATE TABLE [datagen].[DimProduct](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductSubcategoryKey] [int] NOT NULL,
	[StandardCost] [decimal](9,4) NULL,
	[ListPrice] [decimal](9,4) NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	--[FinishedGoodsFlag] [bit] NOT NULL,
	--[Color] [nvarchar](15) NOT NULL,
	--[ProductLine] [nchar](2) NULL,
	[Brand] [int] NULL,
	[Model] [int] NULL,
	[Size] [decimal](9,4) NULL,
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](9,4) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	--[Description] [nvarchar](400) NULL,
	--[Status] [nvarchar](7) NULL,
 CONSTRAINT [PKdatagen_DimProduct_ProductKey] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [datagen].[DimProduct]  WITH CHECK ADD  CONSTRAINT [FKdatagen_DimProduct_DimProductSubcategory] FOREIGN KEY([ProductSubcategoryKey])
REFERENCES [datagen].[DimProductSubcategory] ([ProductSubcategoryKey])
GO

ALTER TABLE [datagen].[DimProduct] CHECK CONSTRAINT [FKdatagen_DimProduct_DimProductSubcategory]
GO







CREATE TABLE [datagen].[DimDate](
	[DateKey] [int] NOT NULL,
	[Date] [date] NOT NULL,
 CONSTRAINT [PKdatagen_DimDate_DateKey] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO




CREATE TABLE [datagen].[DimGeography](
	[GeographyKey] [int] IDENTITY(1,1) NOT NULL,
	[City] [nvarchar](30) NULL,
	[StateProvinceCode] [nvarchar](3) NULL,
	[StateProvinceName] [nvarchar](50) NULL,
	[CountryRegionCode] [nvarchar](3) NULL,
	[CountryRegionName] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](15) NULL,
	--[SalesTerritoryKey] [int] NULL,
 CONSTRAINT [PKdatagen_DimGeography_GeographyKey] PRIMARY KEY CLUSTERED 
(
	[GeographyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO









CREATE TABLE [datagen].[DimCustomer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[GeographyKey] [int] NULL,
	--[CustomerAlternateKey] [nvarchar](15) NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[AddressLine1] [nvarchar](120) NULL,
	[AddressLine2] [nvarchar](120) NULL,
 CONSTRAINT [PKdatagen_DimCustomer_CustomerKey] PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [datagen].[DimCustomer]  WITH CHECK ADD  CONSTRAINT [FKdatagen_DimCustomer_DimGeography] FOREIGN KEY([GeographyKey])
REFERENCES [datagen].[DimGeography] ([GeographyKey])
GO

ALTER TABLE [datagen].[DimCustomer] CHECK CONSTRAINT [FKdatagen_DimCustomer_DimGeography]
GO







CREATE TABLE [datagen].[Sales](
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	--[PromotionKey] [int] NOT NULL,
	--[SalesTerritoryKey] [int] NOT NULL,
	[SalesOrderNumber] [nvarchar](20) NOT NULL,
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [decimal](19,4) NOT NULL,
	--[ExtendedAmount] [decimal](19,4) NOT NULL,
	--[UnitPriceDiscountPct] [decimal](9,4) NOT NULL,
	--[DiscountAmount] [decimal](9,4) NOT NULL,
	--[ProductStandardCost] [decimal](9,4) NOT NULL,
	--[TotalProductCost] [decimal](19,4) NOT NULL,
	--[SalesAmount] [decimal](19,4) NOT NULL,
	--[TaxAmt] [decimal](9,4) NOT NULL,
	--[CustomerPONumber] [nvarchar](25) NULL,
	[TransactionDate] [datetime] NULL,
 CONSTRAINT [PKdatagen_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[SalesOrderLineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [datagen].[Sales]  WITH CHECK ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimCustomer] FOREIGN KEY([CustomerKey])
REFERENCES [datagen].[DimCustomer] ([CustomerKey])
GO

ALTER TABLE [datagen].[Sales]  WITH CHECK ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimProduct] FOREIGN KEY([ProductKey])
REFERENCES [datagen].[DimProduct] ([ProductKey])
GO

ALTER TABLE [datagen].[Sales]  WITH CHECK ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimDate] FOREIGN KEY([OrderDateKey])
REFERENCES [datagen].[DimDate] ([DateKey])
GO

ALTER TABLE [datagen].[Sales] CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimCustomer]
GO

ALTER TABLE [datagen].[Sales] CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimProduct]
GO

ALTER TABLE [datagen].[Sales] CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimDate]
GO





--CREATE TABLE [datagen].[DimPromotion](
--	[PromotionKey] [int] IDENTITY(1,1) NOT NULL,
--	--[PromotionAlternateKey] [int] NULL,
--	[PromotionName] [nvarchar](255) NULL,
--	[DiscountPct] [decimal](9,4) NULL,
--	[PromotionType] [nvarchar](50) NULL,
--	[PromotionCategory] [nvarchar](50) NULL,
--	[StartDate] [datetime] NOT NULL,
--	[EndDate] [datetime] NULL,
--	[MinQty] [int] NULL,
--	[MaxQty] [int] NULL,
-- CONSTRAINT [PKdatagen_DimPromotion_PromotionKey] PRIMARY KEY CLUSTERED 
--(
--	[PromotionKey] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--


--CREATE TABLE [datagen].[DimSalesTerritory](
--	[SalesTerritoryKey] [int] IDENTITY(1,1) NOT NULL,
--	[SalesTerritoryRegion] [nvarchar](50) NOT NULL,
--	[SalesTerritoryCountry] [nvarchar](50) NOT NULL,
--	[SalesTerritoryGroup] [nvarchar](50) NULL,
-- CONSTRAINT [PKdatagen_DimSalesTerritory_SalesTerritoryKey] PRIMARY KEY CLUSTERED 
--(
--	[SalesTerritoryKey] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [datagen].[DimGeography]  WITH CHECK ADD  CONSTRAINT [FKdatagen_DimGeography_DimSalesTerritory] FOREIGN KEY([SalesTerritoryKey])
--REFERENCES [datagen].[DimSalesTerritory] ([SalesTerritoryKey])
--GO

--ALTER TABLE [datagen].[DimGeography] CHECK CONSTRAINT [FKdatagen_DimGeography_DimSalesTerritory]
--GO


--CREATE TABLE [datagen].[DimCurrency](
--	[CurrencyKey] [int] IDENTITY(1,1) NOT NULL,
--	[CurrencyName] [nvarchar](50) NOT NULL,
-- CONSTRAINT [PKdatagen_DimCurrency_CurrencyKey] PRIMARY KEY CLUSTERED 
--(
--	[CurrencyKey] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [datagen].[Sales]  WITH CHECK ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimPromotion] FOREIGN KEY([PromotionKey])
--REFERENCES [datagen].[DimPromotion] ([PromotionKey])
--GO

--ALTER TABLE [datagen].[Sales]  WITH CHECK ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimSalesTerritory] FOREIGN KEY([SalesTerritoryKey])
--REFERENCES [datagen].[DimSalesTerritory] ([SalesTerritoryKey])
--GO

--ALTER TABLE [datagen].[Sales] CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimPromotion]
--GO

--ALTER TABLE [datagen].[Sales] CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimSalesTerritory]
--GO


