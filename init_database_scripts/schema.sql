--pushd ~/sandbox && ./runsql <<<echo $(cat ../assets.docker/grocery_data_generator/grocery_data_generator/CREATE_DATABASE/schema.sql) && popd
CREATE SCHEMA [datagen]
