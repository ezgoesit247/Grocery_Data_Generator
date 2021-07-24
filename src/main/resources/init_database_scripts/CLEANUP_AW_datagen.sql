
DELETE SUB FROM
(SELECT ROW_NUMBER() OVER (PARTITION BY [VendorKey],[BrandKey] ORDER BY [VendorKey]) cnt
 FROM [VendorBrand]) SUB
WHERE SUB.cnt > 1

DELETE SUB FROM
(SELECT ROW_NUMBER() OVER (PARTITION BY [VendorKey],[ModelKey] ORDER BY [VendorKey]) cnt
 FROM [VendorModel]) SUB
WHERE SUB.cnt > 1


CREATE UNIQUE CLUSTERED INDEX [PK_VendorBrand] ON [VendorBrand]
(
  [VendorKey] ASC,
  [BrandKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
) ON [PRIMARY]


CREATE UNIQUE CLUSTERED INDEX [PK_VendorModel] ON [VendorModel]
(
  [VendorKey] ASC,
  [ModelKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
) ON [PRIMARY]



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

