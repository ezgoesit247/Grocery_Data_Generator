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
select p.Product,b.Brand,m.Model from DimProduct p
  LEFT JOIN DimModel m ON p.ModelKey = m.ModelKey
  LEFT JOIN DimBrand b ON p.BrandKey = b.BrandKey;
-- PRODUCT > BRAND > VENDOR
select p.Product,b.Brand,v.Vendor from DimProduct p
  LEFT JOIN DimBrand b ON p.BrandKey = b.BrandKey
  LEFT JOIN VendorBrand vb ON vb.Brandkey = b.BrandKey
  LEFT JOIN DimVendor v on v.VendorKey = vb.VendorKey
order by Product,Vendor,Brand
-- PRODUCT > BRAND > VENDOR COUNT
select p.Product,b.Brand,count(v.Vendor) Vendors from DimProduct p
  LEFT JOIN DimBrand b ON p.BrandKey = b.BrandKey
  LEFT JOIN VendorBrand vb ON vb.Brandkey = b.BrandKey
  LEFT JOIN DimVendor v on v.VendorKey = vb.VendorKey
group by p.Product,b.Brand
order by Product,Brand
-- PRODUCT > BRAND > VENDOR COUNT DISTRIBUTION
select Vendors [BrandVendors], count(Vendors) [Count] from (
select p.Product,b.Brand,count(v.Vendor) Vendors from DimProduct p
  LEFT JOIN DimBrand b ON p.BrandKey = b.BrandKey
  LEFT JOIN VendorBrand vb ON vb.Brandkey = b.BrandKey
  LEFT JOIN DimVendor v on v.VendorKey = vb.VendorKey
group by p.Product,b.Brand
) t group by Vendors
order by [BrandVendors]
-- PRODUCT > MODEL > VENDOR
select p.Product,m.Model,v.Vendor from DimProduct p
  LEFT JOIN DimModel m ON p.ModelKey = m.ModelKey
  LEFT JOIN VendorModel vm ON vm.Modelkey = m.ModelKey
  LEFT JOIN DimVendor v on v.VendorKey = vm.VendorKey
order by Product,Vendor,Model
-- PRODUCT > MODEL > VENDOR COUNT
select p.Product,m.Model,count(v.Vendor) Vendors from DimProduct p
  LEFT JOIN DimModel m ON p.ModelKey = m.ModelKey
  LEFT JOIN VendorModel vm ON vm.Modelkey = m.ModelKey
  LEFT JOIN DimVendor v on v.VendorKey = vm.VendorKey
group by p.Product,m.Model
order by Product,Model
-- PRODUCT > MODEL > VENDOR COUNT DISTRIBUTION
select Vendors [ModelVendors], count(Vendors) [Count] from (
select p.Product,m.Model,count(v.Vendor) Vendors from DimProduct p
  LEFT JOIN DimModel m ON p.ModelKey = m.ModelKey
  LEFT JOIN VendorModel vm ON vm.Modelkey = m.ModelKey
  LEFT JOIN DimVendor v on v.VendorKey = vm.VendorKey
group by p.Product,m.Model
) t group by Vendors
order by [ModelVendors]
-- COUNT OF SUBCATEGORIES IN CATEGORY
select c.Category, COUNT(SubcategoryKey) Subcategories from DimProductCategory c 
  LEFT JOIN DimProductSubcategory s ON c.CategoryKey = s.CategoryKey
group by c.Category;
-- COUNT OF PRODUCT IN SUBCATEGORRY
select SUM(Products) from (
select s.Subcategory, COUNT(p.ProductKey) Products from DimProductSubcategory s
  LEFT JOIN DimProduct p ON p.SubcategoryKey = s.SubcategoryKey
group by s.Subcategory
) t;
-- CATEGORY > SUBCATEGORY > PRODUCT
select p.Product, s.Subcategory, c.Category from DimProduct p
  left join DimProductSubcategory s ON p.SubcategoryKey = s.SubcategoryKey
  left join DimProductCategory c on c.CategoryKey = s.CategoryKey
order by Category, Subcategory, Product;

-- DUPLICATE PRODUCTS, SHOULD BE 0
select p.Product, count(*) from DimProduct p
group by Product
having count(*) > 1
-- DUPLICATE VENDORBRAND
select COUNT(*) from VendorBrand;
select SUM([Duplicates]) from (
select VendorKey,BrandKey ,COUNT(*) [Duplicates]
from VendorBrand
group by VendorKey,BrandKey
having COUNT(*) > 1
) t;
-- DELETE DUPS
delete vb from VendorBrand vb
join VendorBrand vb1 on vb1.VendorKey = vb.VendorKey
  and vb1.BrandKey = vb.BrandKey
  and vb.UK > vb1.UK;
-- DUPLICATE VENDORMODEL
select COUNT(*) from VendorModel;
select SUM([Duplicates]) from (
select VendorKey,ModelKey ,COUNT(*) [Duplicates]
from VendorModel
group by VendorKey,ModelKey
having COUNT(*) > 1
) t;
-- DELETE DUPS
delete vm from VendorModel vm
join VendorModel vm1 on vm1.VendorKey = vm.VendorKey
  and vm1.ModelKey = vm.ModelKey
  and vm.UK > vm1.UK;
  