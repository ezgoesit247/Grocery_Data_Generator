IF NOT EXISTS (SELECT 0
               FROM information_schema.schemata 
               WHERE schema_name='datagen')
begin
  EXEC sp_executesql N'CREATE SCHEMA datagen';
end
