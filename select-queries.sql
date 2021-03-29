SELECT count(*) FROM DimBrand;
SELECT count(*) FROM DimCustomer;
SELECT count(*) FROM DimGeography;
SELECT count(*) FROM DimModel;
SELECT count(*) FROM DimProduct;
SELECT count(*) FROM DimProductCategory;
SELECT count(*) FROM DimProductSubcategory;
SELECT count(*) FROM DimVendor;
SELECT count(*) FROM VendorProduct;
SELECT count(*) FROM Sales;



SELECT * FROM DimBrand;
SELECT * FROM DimProduct;
SELECT * FROM DimModel;
SELECT * FROM DimProductSubcategory;
SELECT * FROM DimVendor;
SELECT * FROM VendorProduct;

-- PRODUCT > BRAND > MODEL
select p.ProductKey,p.BrandKey,m.ModelKey from
  DimProduct p LEFT JOIN DimModel m ON p.ProductKey = m.ProductKey;
-- PRODUCT > BRAND > COUNT OF MODELS
select p.ProductKey,p.BrandKey,COUNT(m.ModelKey) `Models` from
  DimProduct p LEFT JOIN DimModel m ON p.ProductKey = m.ProductKey
    GROUP BY p.ProductKey,p.BrandKey;

-- CATEGORY > SUBCATEGORY
select c.CategoryKey, COUNT(SubcategoryKey) `Subcategories` from 
  DimProductCategory c LEFT JOIN DimProductSubcategory s ON c.CategoryKey = s.CategoryKey
    group by c.CategoryKey;
-- SUBCATEGORRY > PRODUCT
--select SUM(Products) from (
select s.SubcategoryKey, COUNT(p.ProductKey) Products from DimProductSubcategory s
  LEFT JOIN DimProduct p ON p.SubcategoryKey = s.SubcategoryKey
    group by s.SubcategoryKey
--) t;
-- PRODUCT WITH COUNT OF VENDORS
select p.ProductKey, count(vp.VendorKey) `Vendors` from DimProduct p
  left join VendorProduct vp on p.ProductKey = vp.ProductKey
  group by p.ProductKey;
    
-- DUPLICATE VENDORPRODUCT
select VendorKey,ProductKey ,COUNT(*)
from VendorProduct
group by VendorKey,ProductKey
having COUNT(*) > 1
-- DELETE DUPS
delete vp from VendorProduct vp
join VendorProduct vp1 on vp1.VendorKey = vp.VendorKey
  and vp1.ProductKey = vp.ProductKey
  and vp.PK > vp1.PK;
  
  