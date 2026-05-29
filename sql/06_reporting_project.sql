/*
    Script: 06_reporting_project.sql
    Description: This script creates the reporting layer views
        The reporting layer provides final summaries for analysis and dashboards

    Note: this layer uses views based on analytics and core tables.
*/

--Begin transaction
BEGIN;

--Drop reporting views if they already exist.
DROP VIEW IF EXISTS reporting.daily_activity_summary;
DROP VIEW IF EXISTS reporting.user_post_summary;

--Create views for reporting summaries
CREATE VIEW reporting.user_post_summary AS 
SELECT 
    u.user_id,
    u.username,
    u.email,
    COUNT(p.post_id) AS total_posts,
    MIN(p.created_at) AS first_post_date,
    MAX(p.created_at) AS latest_post_date
FROM analytics.dim_user u
LEFT JOIN analytics.dim_post p
    ON u.user_id = p.user_id
GROUP BY 
    u.user_id,
    u.username,
    u.email;

CREATE VIEW reporting.daily_activity_summary AS
SELECT 
    activity_date,
    activity_type,
    SUM(activity_count) AS total_activity
FROM analytics.fact_post_activity
GROUP BY
    activity_date,
    activity_type;

COMMIT;
