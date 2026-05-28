/*
    Script: 00_drop_all.sql
    Description: This script drops all schemas and data from the database. 
        Note that the script is intended for local development and practice purposes. 

    Warning: This script uses CASCADE, which will delete all data inside the schemas when run. 
        Use with caution, and only if you are sure you want to delete all data in the schemas. 
*/

--Begin transaction
BEGIN;

DROP SCHEMA IF EXISTS reporting CASCADE;
DROP SCHEMA IF EXISTS analytics CASCADE;
DROP SCHEMA IF EXISTS core CASCADE;
DROP SCHEMA IF EXISTS staging CASCADE;
DROP SCHEMA IF EXISTS raw CASCADE;

COMMIT;

