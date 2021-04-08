delete vb from VendorBrand vb
join VendorBrand vb1 on vb1.VendorKey = vb.VendorKey
  and vb1.BrandKey = vb.BrandKey
  and vb.UK > vb1.UK;
delete vm from VendorModel vm
join VendorModel vm1 on vm1.VendorKey = vm.VendorKey
  and vm1.ModelKey = vm.ModelKey
  and vm.UK > vm1.UK;

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

