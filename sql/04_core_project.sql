/*
    Script: 04_core_project.sql
    Description: This script creates the core layer tables. 
        The Core layer stores cleaned and validated data from the staging layer.
    
    Note: This layer uses PRIMARY KEY, FOREIGN KEY, UNIQUE constraints, and NOT NULL constraints. 
*/

--Begin transaction
BEGIN;

--Drop core tables in this layer if they already exist.
DROP TABLE IF EXISTS core.posts;
DROP TABLE IF EXISTS core.users;

--Create tables
CREATE TABLE core.users (
    id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE core.posts (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES core.users(id) ON DELETE CASCADE
);

--INSERT data from the staging layer
INSERT INTO core.users (
    id,
    username,
    email,
    password_hash,
    created_at
)
SELECT 
    user_id,
    username,
    email,
    password_hash,
    created_at
FROM staging.stg_users;

INSERT INTO core.posts (
    id,
    user_id,
    title,
    content,
    created_at
)
SELECT 
    post_id,
    user_id,
    title,
    content,
    created_at
FROM staging.stg_posts;

COMMIT;

