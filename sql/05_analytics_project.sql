/*
    Script: 05_analytics_project.sql
    Description: This script creates the analytics layer tables. 
        The analytics layer prepares data for analysis and reporting. 

    Note: This layer uses dimension and fact tables. 
*/

--Begin transaction
BEGIN;

--Drop analytics tables if they already exist. 
DROP TABLE IF EXISTS analytics.fact_post_activity;
DROP TABLE IF EXISTS analytics.dim_post;
DROP TABLE IF EXISTS analytics.dim_user;

--Create dimension tables
CREATE TABLE analytics.dim_user (
    user_key INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE analytics.dim_post (
    post_key INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    post_id INT NOT NULL UNIQUE,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE analytics.fact_post_activity (
    activity_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    activity_type VARCHAR(50) NOT NULL,
    activity_count INT NOT NULL,
    activity_date DATE NOT NULL
);

--Insert data from the core layer using SELECT
INSERT INTO analytics.dim_user (
    user_id,
    username,
    email,
    created_at
)
SELECT 
    id,
    username,
    email,
    created_at
FROM core.users;

INSERT INTO analytics.dim_post (
    post_id,
    user_id,
    title,
    content,
    created_at
)
SELECT 
    id,
    user_id,
    title,
    content,
    created_at
FROM core.posts;

INSERT INTO analytics.fact_post_activity (
    user_id,
    post_id,
    activity_type,
    activity_count,
    activity_date
)
SELECT  
    user_id,
    id AS post_id,
    'post_created' AS activity_type,
    1 AS activity_count,
    created_at::DATE AS activity_date
FROM core.posts;

COMMIT;
