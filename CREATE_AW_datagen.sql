DROP TABLE IF EXISTS [Sales]
DROP TABLE IF EXISTS [SalesLine]
DROP TABLE IF EXISTS [SalesOrderNumber]
DROP TABLE IF EXISTS [VendorModel]
DROP TABLE IF EXISTS [VendorBrand]
DROP TABLE IF EXISTS [DimProduct]
DROP TABLE IF EXISTS [DimProductSubcategory]
DROP TABLE IF EXISTS [DimProductCategory]
DROP TABLE IF EXISTS [DimVendor]
DROP TABLE IF EXISTS [DimBrand]
DROP TABLE IF EXISTS [DimModel]
DROP TABLE IF EXISTS [DimPromotion]
DROP TABLE IF EXISTS [DimCurrency]
DROP TABLE IF EXISTS [DimCustomer]
DROP TABLE IF EXISTS [DimDate]
DROP TABLE IF EXISTS [DimGeography]
DROP TABLE IF EXISTS [DimSalesTerritory]


/*DimBrand*/
CREATE TABLE [DimBrand](
	[BrandKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Brand] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKdatagen_DimBrand_BrandKey] PRIMARY KEY CLUSTERED 
(
	[BrandKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


  
  
/*DimModel*/
CREATE TABLE [DimModel](
	[ModelKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKdatagen_DimModel_ModelKey] PRIMARY KEY CLUSTERED 
(
	[ModelKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


  


/*DimVendor*/
CREATE TABLE [DimVendor](
	[VendorKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Vendor] [nvarchar](50) NOT NULL,
	--[BrandKey] [int] NOT NULL DEFAULT 0,
	--[ModelKey] [int] NOT NULL DEFAULT 0,
 CONSTRAINT [PKdatagen_DimVendor_VendorKey] PRIMARY KEY CLUSTERED 
(
	[VendorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]




/*VendorBrand*/
CREATE TABLE [VendorBrand](
	[VendorKey] [int] NOT NULL DEFAULT 0,
	[BrandKey] [int] NOT NULL DEFAULT 0
--, CONSTRAINT [PKdatagen_VendorBrand] PRIMARY KEY CLUSTERED 
--(
--	[VendorKey] ASC,
--	[BrandKey] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [VendorBrand]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_VendorBrand_BrandKey] 
  FOREIGN KEY([BrandKey])
  REFERENCES [DimBrand] ([BrandKey])

ALTER TABLE [VendorBrand]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_VendorBrand_VendorKey] 
  FOREIGN KEY([VendorKey])
  REFERENCES [DimVendor] ([VendorKey])

/*VendorModel*/
CREATE TABLE [VendorModel](
	[VendorKey] [int] NOT NULL DEFAULT 0,
  [ModelKey] [int] NOT NULL DEFAULT 0
--, CONSTRAINT [PKdatagen_VendorModel] PRIMARY KEY CLUSTERED 
--(
--	[VendorKey] ASC,
--  [ModelKey] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
  

ALTER TABLE [VendorModel]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_VendorModel_ModelKey] 
  FOREIGN KEY([ModelKey])
  REFERENCES [DimModel] ([ModelKey])

ALTER TABLE [VendorModel]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_VendorModel_VendorKey] 
  FOREIGN KEY([VendorKey])
  REFERENCES [DimVendor] ([VendorKey])

/*DimProductCategory*/
CREATE TABLE [DimProductCategory](
	[CategoryKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKdatagen_DimProductCategory_ProductCategoryKey] PRIMARY KEY CLUSTERED 
(
	[CategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]




  

/*DimProductSubcategory*/
CREATE TABLE [DimProductSubcategory](
	[SubcategoryKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Subcategory] [nvarchar](50) NOT NULL,
	[CategoryKey] [int] NOT NULL,
 CONSTRAINT [PKdatagen_DimProductSubcategory_ProductSubcategoryKey] PRIMARY KEY CLUSTERED 
(
	[SubcategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [DimProductSubcategory]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_DimProductSubcategory_DimProductCategory] 
  FOREIGN KEY([CategoryKey])
  REFERENCES [DimProductCategory] ([CategoryKey])


  

/*DimProduct*/
CREATE TABLE [DimProduct](
	[ProductKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[SubcategoryKey] [int] NOT NULL,
	[StandardCost] [decimal](9,4) NULL,
	[ListPrice] [decimal](9,4) NOT NULL,
	[Product] [nvarchar](50) NOT NULL,
	--[FinishedGoodsFlag] [bit] NOT NULL,
	--[Color] [nvarchar](15) NOT NULL,
	--[ProductLine] [nchar](2) NULL,
	[BrandKey] [int] NOT NULL DEFAULT 0,
	[ModelKey] [int] NOT NULL DEFAULT 0,
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


ALTER TABLE [DimProduct]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_DimProduct_DimProductSubcategory] 
  FOREIGN KEY([SubcategoryKey])
  REFERENCES [DimProductSubcategory] ([SubcategoryKey])

  
ALTER TABLE [DimProduct]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_DimProduct_DimModel] 
  FOREIGN KEY([ModelKey])
  REFERENCES [DimModel] ([ModelKey])


ALTER TABLE [DimProduct]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_DimProduct_DimBrand] 
  FOREIGN KEY([BrandKey])
  REFERENCES [DimBrand] ([BrandKey])




/*Geography*/
CREATE TABLE [DimGeography](
	[GeographyKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
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




INSERT INTO [DimGeography] (
	[GeographyKey]
	,[PostalCode]
	,[City]
	,[StateProvinceCode]
	,[CountryRegionCode]
)
	SELECT [PK]
      ,[zip]
      ,[primary_city]
      ,[state]
      ,[country]
	 FROM [datagen].[zip_code_import]

  
  /*DimCustomer*/
CREATE TABLE [DimCustomer](
	[CustomerKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[GeographyKey] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
 CONSTRAINT [PKdatagen_DimCustomer_CustomerKey] PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [DimCustomer]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_DimCustomer_DimGeography] 
  FOREIGN KEY([GeographyKey])
  REFERENCES [DimGeography] ([GeographyKey])
 

  INSERT INTO [DimGeography] (GeographyKey,City,StateProvinceCode,StateProvinceName,CountryRegionCode,CountryRegionName,PostalCode) VALUES (0,'No City','N/A','No State','N/A','No Country','00000')
  INSERT INTO [DimCustomer] (CustomerKey,GeographyKey,FirstName,LastName) VALUES (0,0,'No First','No Last')
  INSERT INTO [DimVendor] (VendorKey,Vendor) VALUES (0,'No Vendor')
  INSERT INTO [DimBrand] (BrandKey,Brand) VALUES (0,'No Brand')
  INSERT INTO [DimModel] (ModelKey,Model) VALUES (0,'No Model')
  INSERT INTO [DimProductCategory] (CategoryKey,Category) VALUES (0,'No Category')
  INSERT INTO [DimProductSubcategory] (SubcategoryKey,CategoryKey,Subcategory) VALUES (0,0,'No Subcategory')
  INSERT INTO [DimProduct] (ProductKey,SubcategoryKey,Product,ListPrice) VALUES (0,0,'No Product',0)
  

  
CREATE TABLE [SalesOrderNumber](
  [SalesOrderNumber] [bigint] NOT NULL default 0,
  [TransactionDate] [datetime] NULL,
 CONSTRAINT [PKdatagen_SalesOrderNumber_SalesOrderNumber] PRIMARY KEY CLUSTERED 
(
  [SalesOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]




CREATE TABLE [SalesLine](
  [SalesKey] [bigint] /*IDENTITY(1,1)*/ NOT NULL,
  [SalesOrderNumber] [bigint] NOT NULL DEFAULT 0,
  [LineNumber] [int] NOT NULL DEFAULT 1,
 CONSTRAINT [PKdatagen_SalesLine_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED 
(
  [SalesKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [SalesLine]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_SalesLine_SalesOrderNumber] 
  FOREIGN KEY([SalesOrderNumber])
  REFERENCES [SalesOrderNumber] ([SalesOrderNumber])

CREATE UNIQUE NONCLUSTERED INDEX [salesordernumberline_uidx] ON [SalesLine]
(
  [SalesOrderNumber] ASC,
  [LineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


/*Sales*/
CREATE TABLE [Sales](
  [SalesKey] [bigint] /*IDENTITY(1,1)*/ NOT NULL,
	[ProductKey] [int] NOT NULL DEFAULT 0,
	[CustomerKey] [int] NOT NULL DEFAULT 0,
	[Quantity] [int] NOT NULL DEFAULT 1,
	[UnitPrice] [decimal](19,4) NOT NULL DEFAULT 0,
--  [SalesOrderNumber] [bigint] NOT NULL DEFAULT 0,
--  [LineNumber] [int] NOT NULL DEFAULT 1
 CONSTRAINT [PKdatagen_Sales_SalesKey] PRIMARY KEY CLUSTERED 
(
	[SalesKey] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Sales]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_Sales_SalesKey] 
  FOREIGN KEY([SalesKey])
  REFERENCES [SalesLine] ([SalesKey])




/*SalesLine*/
--CREATE TABLE [SalesLine](
--  [SalesOrderNumber] [bigint] NOT NULL DEFAULT 0,
--  [LineNumber] [int] NOT NULL DEFAULT 1,
-- CONSTRAINT [PKdatagen_SalesLine_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED 
--(
--  [SalesOrderNumber] ASC,
--  [LineNumber] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]

/*Sales*/
--CREATE TABLE [Sales](
--  [SalesKey] [bigint] IDENTITY(1,1) NOT NULL,
--  [ProductKey] [int] NOT NULL DEFAULT 0,
--  [CustomerKey] [int] NOT NULL DEFAULT 0,
--  [Quantity] [int] NOT NULL DEFAULT 1,
--  [UnitPrice] [decimal](19,4) NOT NULL DEFAULT 0,
--  [SalesOrderNumber] [bigint] NOT NULL DEFAULT 0,
--  [LineNumber] [int] NOT NULL DEFAULT 1
-- ,CONSTRAINT [PKdatagen_Sales_SalesKey] PRIMARY KEY CLUSTERED 
--(
--  [SalesKey] ASC
--) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--
--
--CREATE UNIQUE NONCLUSTERED INDEX [salesordernumberline_uidx] ON [Sales]
--(
--  [SalesOrderNumber] ASC,
--  [LineNumber] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

--ALTER TABLE [Sales]  WITH CHECK 
--  ADD  CONSTRAINT [FKdatagen_Sales_SalesOrderNumber] 
--  FOREIGN KEY([SalesOrderNumber])
--  REFERENCES [SalesOrderNumber] ([SalesOrderNumber])



ALTER TABLE [Sales]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimProduct] 
  FOREIGN KEY([ProductKey])
  REFERENCES [DimProduct] ([ProductKey])


ALTER TABLE [Sales]  WITH CHECK 
  ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimCustomer] 
  FOREIGN KEY([CustomerKey])
  REFERENCES [DimCustomer] ([CustomerKey])




/*

	INSERT THESE AFTER THE RUN TO VALIDATE
	


ALTER TABLE [DimProductSubcategory] 
  CHECK CONSTRAINT [FKdatagen_DimProductSubcategory_DimProductCategory]


ALTER TABLE [DimProduct] 
  CHECK CONSTRAINT [FKdatagen_DimProduct_DimProductSubcategory]


ALTER TABLE [SalesLine] 
  CHECK CONSTRAINT [FKdatagen_SalesLine_SalesOrderNumber]


ALTER TABLE [Sales] 
  CHECK CONSTRAINT [FKdatagen_Sales_SalesKey]


ALTER TABLE [Sales] 
  CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimProduct]


ALTER TABLE [Sales] 
  CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimCustomer]


ALTER TABLE [DimCustomer] 
  CHECK CONSTRAINT [FKdatagen_DimCustomer_DimGeography]


ALTER TABLE [DimProduct] 
  CHECK CONSTRAINT FKdatagen_DimProduct_DimModel


ALTER TABLE [DimProduct] 
  CHECK CONSTRAINT FKdatagen_DimProduct_DimBrand





*/
	