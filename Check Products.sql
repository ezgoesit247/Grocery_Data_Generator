
/****** 
	CHECK ON BRANDS MODELS
******/
SELECT  '[count]',count(*)
	  --c.[CategoryKey],c.[Category]
	  --,s.SubcategoryKey,s.Subcategory
	  --,p.ProductKey,p.Product,p.BrandKey,b.Brand,p.ModelKey,m.Model
  FROM [AdventureWorksDW2016].[datagen].[DimProductCategory] c
  JOIN [AdventureWorksDW2016].[datagen].DimProductSubcategory s on c.CategoryKey=s.CategoryKey
  JOIN [AdventureWorksDW2016].[datagen].DimProduct p on p.SubcategoryKey=s.SubcategoryKey
  LEFT JOIN [AdventureWorksDW2016].[datagen].DimBrand b on b.BrandKey=p.BrandKey
  LEFT JOIN [AdventureWorksDW2016].[datagen].DimModel m on m.ModelKey=p.ModelKey
UNION ALL
SELECT '[count null brand/model]',count(*)
	  --c.[CategoryKey],c.[Category]
	  --,s.SubcategoryKey,s.Subcategory
	  --,p.ProductKey,p.Product,p.BrandKey,b.Brand,p.ModelKey,m.Model
  FROM [AdventureWorksDW2016].[datagen].[DimProductCategory] c
  JOIN [AdventureWorksDW2016].[datagen].DimProductSubcategory s on c.CategoryKey=s.CategoryKey
  JOIN [AdventureWorksDW2016].[datagen].DimProduct p on p.SubcategoryKey=s.SubcategoryKey
  LEFT JOIN [AdventureWorksDW2016].[datagen].DimBrand b on b.BrandKey=p.BrandKey
  LEFT JOIN [AdventureWorksDW2016].[datagen].DimModel m on m.ModelKey=p.ModelKey
  WHERE b.Brand is NULL OR m.Model is NULL
  
/****** 
	RETURNS THE NUMBER OF MISMATCHED PRODUCTS
******/
SELECT COUNT(*)
  FROM [AdventureWorksDW2016].[datagen].[Sales] f
  JOIN [AdventureWorksDW2016].[datagen].[DimProduct] p
	on f.[ProductKey]=p.[ProductKey]
	WHERE Product IS NULL



/****** 
	SELECTS QUANTITIES AND PRICES
******/
	select [lbl],[val],[cnt] from (
select 'unitprice' [lbl],unitprice [val],count(*) [cnt] from sales
group by unitprice
--order by unitprice
Union all
select 'Quantity',Quantity,count(*) [cnt] from sales
group by Quantity
--order by Quantity
) t 
order by [lbl],[val],[cnt]
  