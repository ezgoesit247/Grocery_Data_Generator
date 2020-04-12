DROP TABLE IF EXISTS [datagen].[Sales]
DROP TABLE IF EXISTS [datagen].[DimProduct]
DROP TABLE IF EXISTS [datagen].[DimProductSubcategory]
DROP TABLE IF EXISTS [datagen].[DimProductCategory]
DROP TABLE IF EXISTS [datagen].[DimBrand]
DROP TABLE IF EXISTS [datagen].[DimModel]
DROP TABLE IF EXISTS [datagen].[DimPromotion]
DROP TABLE IF EXISTS [datagen].[DimCurrency]
DROP TABLE IF EXISTS [datagen].[DimCustomer]
DROP TABLE IF EXISTS [datagen].[DimDate]
DROP TABLE IF EXISTS [datagen].[DimGeography]
DROP TABLE IF EXISTS [datagen].[DimSalesTerritory]

/*DimBrand*/
CREATE TABLE [datagen].[DimBrand](
	[BrandKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Brand] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKdatagen_DimBrand_BrandKey] PRIMARY KEY CLUSTERED 
(
	[BrandKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

  INSERT INTO [datagen].[DimBrand] (BrandKey,Brand) VALUES (0,'No Brand')
  
/*DimModel*/
CREATE TABLE [datagen].[DimModel](
	[ModelKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKdatagen_DimModel_ModelKey] PRIMARY KEY CLUSTERED 
(
	[ModelKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

  INSERT INTO [datagen].[DimModel] (ModelKey,Model) VALUES (0,'No Model')

/*DimProductCategory*/
CREATE TABLE [datagen].[DimProductCategory](
	[CategoryKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKdatagen_DimProductCategory_ProductCategoryKey] PRIMARY KEY CLUSTERED 
(
	[CategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

  INSERT INTO [datagen].[DimProductCategory] (CategoryKey,Category) VALUES (0,'No Category')

/*DimProductSubcategory*/
CREATE TABLE [datagen].[DimProductSubcategory](
	[SubcategoryKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[Subcategory] [nvarchar](50) NOT NULL,
	[CategoryKey] [int] NOT NULL,
 CONSTRAINT [PKdatagen_DimProductSubcategory_ProductSubcategoryKey] PRIMARY KEY CLUSTERED 
(
	[SubcategoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

  INSERT INTO [datagen].[DimProductSubcategory] (SubcategoryKey,CategoryKey,Subcategory) VALUES (0,0,'No Subcategory')

/*DimProduct*/
CREATE TABLE [datagen].[DimProduct](
	[ProductKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[SubcategoryKey] [int] NOT NULL,
	[StandardCost] [decimal](9,4) NULL,
	[ListPrice] [decimal](9,4) NULL,
	[Product] [nvarchar](50) NOT NULL,
	--[FinishedGoodsFlag] [bit] NOT NULL,
	--[Color] [nvarchar](15) NOT NULL,
	--[ProductLine] [nchar](2) NULL,
	[BrandKey] [int] NOT NULL DEFAULT 0,
	[ModelKey] [int] NULL DEFAULT 0,
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

  INSERT INTO [datagen].[DimProduct] (ProductKey,SubcategoryKey,Product) VALUES (0,0,'No Product')

/*Geography*/
CREATE TABLE [datagen].[DimGeography](
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

  INSERT INTO [datagen].[DimGeography] (GeographyKey,City,StateProvinceCode,StateProvinceName,CountryRegionCode,CountryRegionName,PostalCode) 
  	VALUES (0,0,'No City','N/A','No State','N/A','No Country','00000')

/*DimCustomer*/
CREATE TABLE [datagen].[DimCustomer](
	[CustomerKey] [int] /*IDENTITY(1,1)*/ NOT NULL,
	[GeographyKey] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
 CONSTRAINT [PKdatagen_DimCustomer_CustomerKey] PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


  INSERT INTO [datagen].[DimCustomer] (CustomerKey,GeographyKey,[FirstName],[LastName]) VALUES (0,0,'No First','No Last')

/*Sales*/
CREATE TABLE [datagen].[Sales](
	[ProductKey] [int] NOT NULL DEFAULT 0,
	[CustomerKey] [int] NOT NULL DEFAULT 0,
	[SalesOrderNumber] [nvarchar](20) NOT NULL,
	[SalesOrderLineNumber] [tinyint] NOT NULL DEFAULT 1,
	[Quantity] [smallint] NOT NULL DEFAULT 1,
	[UnitPrice] [decimal](19,4) NOT NULL DEFAULT 0,
	[TransactionDate] [datetime] NULL,
 CONSTRAINT [PKdatagen_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[SalesOrderLineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]




ALTER TABLE [datagen].[DimProductSubcategory]  WITH CHECK 
	ADD  CONSTRAINT [FKdatagen_DimProductSubcategory_DimProductCategory] 
	FOREIGN KEY([CategoryKey])
	REFERENCES [datagen].[DimProductCategory] ([CategoryKey])

ALTER TABLE [datagen].[DimProduct]  WITH CHECK 
	ADD  CONSTRAINT [FKdatagen_DimProduct_DimProductSubcategory] 
	FOREIGN KEY([SubcategoryKey])
	REFERENCES [datagen].[DimProductSubcategory] ([SubcategoryKey])

ALTER TABLE [datagen].[Sales]  WITH CHECK 
	ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimProduct] 
	FOREIGN KEY([ProductKey])
	REFERENCES [datagen].[DimProduct] ([ProductKey])

ALTER TABLE [datagen].[Sales]  WITH CHECK 
	ADD  CONSTRAINT [FKdatagen_FactInternetSales_DimCustomer] 
	FOREIGN KEY([CustomerKey])
	REFERENCES [datagen].[DimCustomer] ([CustomerKey])

ALTER TABLE [datagen].[DimCustomer]  WITH CHECK 
	ADD  CONSTRAINT [FKdatagen_DimCustomer_DimGeography] 
	FOREIGN KEY([GeographyKey])
	REFERENCES [datagen].[DimGeography] ([GeographyKey])



ALTER TABLE [datagen].[DimProductSubcategory] 
	CHECK CONSTRAINT [FKdatagen_DimProductSubcategory_DimProductCategory]

ALTER TABLE [datagen].[DimProduct] 
	CHECK CONSTRAINT [FKdatagen_DimProduct_DimProductSubcategory]

ALTER TABLE [datagen].[Sales] 
	CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimProduct]

ALTER TABLE [datagen].[Sales] 
	CHECK CONSTRAINT [FKdatagen_FactInternetSales_DimCustomer]

ALTER TABLE [datagen].[DimCustomer] 
	CHECK CONSTRAINT [FKdatagen_DimCustomer_DimGeography]






