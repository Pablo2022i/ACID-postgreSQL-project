/*
    Script: 03_staging_project.sql
    Description: This script creates the tables for the staging layer.
        The staging project is the second step in the data pipeline, and it is where we will store the cleaned and transformed data that we will later load into the core, analytics, and reporting schemas.
*/

--Begin transaction
BEGIN;

--Drop tables with previous staging layers
DROP TABLE IF EXISTS staging.stg_posts;
DROP TABLE IF EXISTS staging.stg_users;

--Create tables using SELECT to save the clean output. 
CREATE TABLE staging.stg_users AS
SELECT 
    raw_user_id::INT AS user_id,
    LOWER(TRIM(username)) AS username,
    LOWER(TRIM(email)) AS email,
    password_hash,
    created_at::TIMESTAMP AS created_at
FROM raw.raw_users;

CREATE TABLE staging.stg_posts AS
SELECT 
    raw_post_id::INT AS post_id,
    raw_user_id::INT AS user_id,
    TRIM(title) AS title,
    TRIM(content) AS content,
    created_at::TIMESTAMP AS created_at
FROM raw.raw_posts;

COMMIT;
