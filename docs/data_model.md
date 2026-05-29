# Data Model

## Overview
This document explains the main tables and relationships used in this PostreSQL data pipeline project. 

The project is organized into different data layers:
```text
raw -> staging -> core -> analytics -> reporting.
```
The main relational model in built in the ```core``` layer, and the analytical model in the ```analytics``` layer. 

## Core Data Model
This layer stores the cleaned and validated relational tables.

### core.users
The ```core.users ``` table stores the user records. 

**Main columns:**
- id: Primary key for each user.
- username: unique username.
- email: unique user email.
- password_hash: stored password as a hash value.
- created_at: Timestamp when the user was created.

### core.posts
The ```core.posts``` table stores the posts records. 

**Main columns:**
- id: Primary key for each post.
- user_id: Foreign key that connects each post to a user. 
- title: post title.
- content: post content.
- created_at: timestamp of when the post was created. 

## Core Relationship
The main relationship in the core layer is:

```text
core.users.id -> core.posts.user_id
```

This means that every post has a user that created it. 

**Example:**

```text
core.users
id | username
1    pablo

core.posts 
id | user_id | title
1       1      Learning data pipelines
2       1      Learning SQL
3       2      Learning ACID
```

In this example, we see that every post has an id; however, every post belongs to a user ```(user_id)```.

<br>

## Analytics Data Model
The analytics layer prepares and organizes the data for analysis and reporting. 

### analytics.dim_user
This table describes users for analysis. 

**Main columns:**
- user_key: internal analytics key.
- user_id: original user ID from core.users.
- username: unique username.
- email: user email.
- created_at: timestamp when the user was created.

### analytics.dim_post
This table describes the posts for analysis. 

**Main columns:**
- post_key: internal analytics key. 
- post_id: original post ID from core.posts.
- user_id: original user ID from core.users.
- title: post title.
- content: post content.
-created_at: timestamp when post was created.

### analytics.fact_post_activity
This table stores post activity events.

**Main columns:**
- activity_id: Primary key for each activity record.
- user_id: User who performed the activity.
- post_id: Post related to the activity.
- activity_type: Type of activity, such as post_created.
- activity_count: Count value used for aggregation.
- activity_date: Date of the activity.

## Analytics Relationship
```text
analytics.dim_users.user_id -> analytics.dim_post.user_id
analytics.dim_post.user_id -> analytics.fact_post_activity.user_id
analytics.dim_posts.post_id -> analytics.fact_post_activity.post_id
```
The dimension tables describe the data for users and posts. The fact table stores measurable activity. 

## Reporting Data Model

### reporting.user_post_summary
This view summarizes post activity by user. 

**Main columns:**
- user_id: User ID.
- username: Username.
- email: User email.
- total_posts: Total number of posts created by the user.
- first_post_date: The first post date for the user.
- latest_post_date: The latest post date for the user.

### reporting.daily_activity_summary
This view summarizes daily activity.

**Main columns:**

- activity_date: Date of the activity.
- activity_type: Type of activity, such as post_created.
- total_activity: Total number of activities for that date and type.

## Why This Model Matters

This model separates the clean and trusted data from the data prepared for analysis. The `core` layer protects data quality by using constraints such as primary keys, foreign keys, unique values, and not null rules.

The `analytics` layer uses that trusted data and organizes it into dimension and fact tables. This makes it easier to answer reporting questions, such as how many posts each user created or how much activity happened each day.






