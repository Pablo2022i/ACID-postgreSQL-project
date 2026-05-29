# PostgreSQL Data Pipeline Project with ACID Foundations

## Project Overview

This project demonstrates a small data pipeline flow built with PostgreSQL. The goal of this project is to show how raw data moves from different data layers until it becomes clean, validated, structured, and ready for reporting.

This pipeline shows this structure:

```text
raw -> staging -> core -> analytics -> reporting
```

Each layer has a specific purpose. The raw layer stores the original data as it comes. The staging layer cleans and trims the data. The core layer validates the data with database constraints. The analytics layer organizes the data for analysis. The reporting layer creates views that are ready for final business summaries.

# Tools Used

* PostgreSQL
* Postgres.app
* VS Code
* SQL
* Terminal / bash / psql
* Git and GitHub

<br><br>

# Data Architecture

### Raw Layer

The raw layer stores the data as it arrives from the source. In this project, the raw layer included users and posts. The data was inserted manually, and it purposely included spaces, lowercase, and uppercase values. The data was stored as **TEXT**.

### Staging Layer

This layer converted the **TEXT** values to the correct data types. The goal for this layer was to transform the data before inserting it into the validated core layer. I also cleaned the data using `LOWER(TRIM(X))`, changed IDs from `TEXT` to integers, and changed dates stored as text to `TIMESTAMP`.

### Core Layer

After getting the data transformed, trimmed, and clean, I built the tables that store the trusted data. I validated the tables so they included correct data types and database constraints, such as `NOT NULL`, `UNIQUE`, `PRIMARY KEY`, and `FOREIGN KEY`. This is the trusted layer of data for the project.

### Analytics

With the cleaned and validated data, I organized the data in preparation for the reporting layer. In analytics, I used dimension and fact tables, including user and post dimensions and a fact table for post activity.

### Reporting Layer

This layer created the final views that summarize the data. The views can be used for analysis, dashboards, or general business reporting.

<br><br>

# Project Structure

```text
ACID-postgreSQL-project/
│
├── README.md
├── docs/
├── screenshots/
└── sql/
    ├── 00_drop_all.sql
    ├── 01_create_schemas.sql
    ├── 02_raw_project.sql
    ├── 03_staging_project.sql
    ├── 04_core_project.sql
    ├── 05_analytics_project.sql
    └── 06_reporting_project.sql
```

# How to Run the Project

Run the SQL files in this order from the project root:

```bash
psql -p 5431 -d acid_inventory_demo -v ON_ERROR_STOP=1 -f sql/00_drop_all.sql
psql -p 5431 -d acid_inventory_demo -v ON_ERROR_STOP=1 -f sql/01_create_schemas.sql
psql -p 5431 -d acid_inventory_demo -v ON_ERROR_STOP=1 -f sql/02_raw_project.sql
psql -p 5431 -d acid_inventory_demo -v ON_ERROR_STOP=1 -f sql/03_staging_project.sql
psql -p 5431 -d acid_inventory_demo -v ON_ERROR_STOP=1 -f sql/04_core_project.sql
psql -p 5431 -d acid_inventory_demo -v ON_ERROR_STOP=1 -f sql/05_analytics_project.sql
psql -p 5431 -d acid_inventory_demo -v ON_ERROR_STOP=1 -f sql/06_reporting_project.sql
```

<br>

# SQL Pipeline Files

### `00_drop_all.sql`

Drops all project schemas and objects. This script includes `CASCADE`, so it is only used locally for development and practice.

### `01_create_schemas.sql`

Creates the main schemas used in the project: raw, staging, core, analytics, and reporting.

### `02_raw_project.sql`

Creates raw tables and inserts sample raw data.

### `03_staging_project.sql`

Creates staging tables by cleaning and transforming the raw data.

### `04_core_project.sql`

Creates the core relational tables with primary keys, foreign keys, unique constraints, and not null constraints.

### `05_analytics_project.sql`

Creates analytics dimension and fact tables and loads data from the core layer.

### `06_reporting_project.sql`

Creates reporting views that summarize user posts and daily activity.

<br>

# Final Reporting Views

### reporting.user_post_summary

This view summarizes post activity by user. It shows each user, their email, total number of posts, first post date, and latest post date.

### reporting.daily_activity_summary

This view summarizes activity by date and activity type. It shows the total number of post creation events per day.

<br>

# Skills Demonstrated

This project demonstrates:

* PostgreSQL schema design
* SQL table creation
* Data cleaning and transformation
* Primary keys and foreign keys
* Unique and not null constraints
* Data modeling
* Dimension and fact tables
* Reporting views
* SQL aggregation with COUNT, MIN, MAX, and SUM
* Git and GitHub project organization

<br>

# Future Improvements

Future improvements could include:

* Loading data from a real CSV file
* Using Python and pandas for ETL
* Adding more entities such as comments, likes, and followers
* Creating indexes for performance
* Adding data quality checks
* Building a dashboard from the reporting views
