--pushd ~/sandbox && ./runsql <<<echo $(cat ../assets.docker/grocery_data_generator/grocery_data_generator/CREATE_DATABASE/zipcodeimport.sql) && popd

CREATE TABLE [GroceryStore].[datagen].[zip_code_import] ( [PK] [int] IDENTITY(1,1) NOT NULL, [zip] [nvarchar](5) NOT NULL, [primary_city] [nvarchar](50) NOT NULL, [state] [nvarchar](2) NOT NULL, [country] [nvarchar](2) NOT NULL )
CREATE UNIQUE NONCLUSTERED INDEX [UNIQUE_ZIPCODE] ON [GroceryStore].[datagen].[zip_code_import] ( [zip] ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
