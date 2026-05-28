/* 
    Script: 01_create_schemas
    Description: This script creates all schemas, and every schema will represent
        a small project.
*/

--Begin transaction
BEGIN;

CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS analytics;
CREATE SCHEMA IF NOT EXISTS reporting;

COMMIT;