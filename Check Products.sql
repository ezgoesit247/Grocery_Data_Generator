use AdventureWorksDW2016

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT c.[CategoryKey],c.[Category]
	  ,s.SubcategoryKey,s.Subcategory
	  ,p.ProductKey,p.Product,p.BrandKey,b.Brand,p.ModelKey,m.Model
  FROM [AdventureWorksDW2016].[datagen].[DimProductCategory] c
  JOIN [AdventureWorksDW2016].[datagen].DimProductSubcategory s on c.CategoryKey=s.CategoryKey
  JOIN [AdventureWorksDW2016].[datagen].DimProduct p on p.SubcategoryKey=s.SubcategoryKey
  JOIN [AdventureWorksDW2016].[datagen].DimBrand b on b.BrandKey=p.BrandKey
  JOIN [AdventureWorksDW2016].[datagen].DimModel m on m.ModelKey=p.ModelKey
  
  
