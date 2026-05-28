/*
    Script: 02_raw_project.sql
    Description: This script creates the tables for the raw project. 
        The raw project is the first step in the data pipeline, and it is where we will store the raw data that we will later transform and load into the staging, core, analytics, and reporting schemas.
        Note: We are using TEXT because data might not or will not be ready yet for production. 
*/

--Begin transaction
BEGIN;

CREATE TABLE IF NOT EXISTS raw.raw_users (
    raw_user_id TEXT,
    username TEXT,
    email TEXT,
    password_hash TEXT,
    created_at TEXT
);

CREATE TABLE IF NOT EXISTS raw.raw_posts (
    raw_post_id TEXT,
    raw_user_id TEXT,
    title TEXT,
    content TEXT,
    created_at TEXT
);

INSERT INTO raw.raw_users (
    raw_user_id,
    username,
    email,
    password_hash,
    created_at
)

VALUES  
    ('1', ' Pablo ', ' PABLO@EMAIL.COM ', 'hash_001', '2026-05-26 10:00:00'),
    ('2', ' Maria ', ' MARIA@EMAIL.COM ', 'hash_002', '2026-05-26 10:05:00'),
    ('3', ' Juan ', ' JUAN@EMAIL.COM ', 'hash_003', '2026-05-26 10:10:00');

INSERT INTO raw.raw_posts (
    raw_post_id,
    raw_user_id,
    title,
    content,
    created_at
)
VALUES
    ('1', '1', ' Learning PostgreSQL ', ' Today I practiced schemas. ', '2026-05-26 11:00:00'),
    ('2', '1', ' Data Engineering ', ' I am learning raw and staging layers. ', '2026-05-26 11:10:00'),
    ('3', '2', ' First Project ', ' This is my first data project. ', '2026-05-26 11:20:00');

COMMIT;