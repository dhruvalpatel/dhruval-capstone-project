# Project Overview

### About
This project is a capstone project for Zach Wilson's Dataexpert.io Data Engineering bootcamp 
In this project, I wanted to apply as many skills as I learnt in the bootcamp, so I took opensource dataset called Brazilian E-Commerce Public Dataset by Olist. 


## Table of Contents
1. [Capstone Requirements](#capstone-requirements)
2. [Project Overview](#project-overview)
    1. [Problem Statement](#problem-statement)
    2. [KPI and Use cases](#kpi-and-use-cases)
    3. [Data Sources](#data-sources)
    4. [Tables in Snowflake](#data-tables)
    5. [Technologies Used](#technologies-used)
    6. [Why I used these tech](#why-i-used-this-tech)
    7. [Architecture](#architecture)
3. [KPI visualizations](#kpis)
4. [Pipeline](#pipeline)
    1. [Tasks in Dag](#tasks-in-dag)
    2. [DBT tests](#dbt-tests)
    3. [Astronomer Cloud](#deployed-in-astronomer-cloud)
5. [Challenges](#challenges-and-findings)

6. [Next Steps](#next-steps)


## Capstone Requirements

* Identify a problem you'd like to solve.
* Scope the project and choose datasets.
* Use at least 2 different data sources and formats (e.g., CSV, JSON, APIs), with at least 1 million rows.
* Define your use case: analytics table, relational database, dashboard, etc.
* Choose your tech stack and justify your choices.
* Explore and assess the data.
* Identify and resolve data quality issues.
* Document your data cleaning steps.
* Create a data model diagram and dictionary.
* Build ETL pipelines to transform and load the data.
* Run pipelines and perform data quality checks.
* Visualize or present the data through dashboards, applications, or reports.
* Your data pipeline must be running in a production cloud environment

## Project Overview
This project is a real-time data pipeline that works with multiple services like Pub/Sub, Google BigQuery, Airflow(Astronomer), DBT and Tableau to monitor order data and other KPIs.

### Problem Statement
* This an attempt to create an entire data warehouse needed for e-comm platform.

### KPI and Use cases
1. Aggregated Monthly Growth

Measures agg monthly customer growth

2. Top Selling Products

Calculates top-selling products over time. Further enhancements can be made by time granularity. 
i.e top-selling products in last month, year etc

3. Sales by sellers

Calculates sales by sellers and displays top sellers with their products

4. Sales trends

Calculates sales trends over time. How total revenue is performing

5. Avg delivery time taken by sellers

Calculates the delivery time taken by sellers which helps to see total average time vs outliers and help them find
root cause of late delivery

6. Average order value by city and state

Calculates average order value by city and state which in term helps to understand customers better

7. Average customer purchase frequency

Calculates average customer purchase frequency per city and state 

8. Average retained customers over months

Calculates average customer came back to purchase over month

### Real-Time Features
9. As soon as order is placed App will call Pub/Sub topic and Dataflow(Apache Beam) will process the
message, here test cases and cleaning will come, and update orders, order_item and order_payments tables
in real-time.

### Data Sources
Mainly I have used this kaggle data source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
and for real-time updates I have created a script to generate fake data.


### Data Tables
#### Staging tables
* Staging tables have almost identical data as have in CSVs.
* stg_customers : contains data of customers 
* stg_geolocation : contains data of zip code, and it's latitude and longitude 
* stg_order_items : contains order items present in an order with integer incremental 
* stg_order_payments : contains data of how payment happens in an order. type and installments 
* stg_orders : contains meta information of order 
* stg_product_category_name_translation : since this data is originally present in spanish, english translation 
is present in this table
* stg_products : contains data of products with its category 
* stg_sellers : contains data of sellers present on platform

#### Prod tables:
* fact_sales : this table contains daily information about the orders, and it is updated
at 11 PM
* dim_product : product information after joining and cleaning the data
* dim_customers : customer information with necessary information about customers
* dim_sellers : seller information


### Technologies Used

The project uses the following technologies:
I have tried to use Google Cloud Platform as much as possible because I have sound experience in it.

Pub/Sub(Kafka equivalent in GCP): Acts as both a message producer for real-time API data and temporary storage until data is consumed and loaded into BigQuery.

BigQuery: Functions as your data warehouse with a three-layer architecture (storage, compute/query processing, and cloud services), offering scalability and near-zero management overhead.

Airflow(Astronomer): Provides workflow management through Directed Acyclic Graphs (DAGs) that define task dependencies and execution order, enabling you to author, schedule, and monitor complex data pipelines.
I could have used composer but astronomer has easy development and deployment process.

Astronomer: A managed platform built on top of Apache Airflow that simplifies deployment, scaling, and monitoring while adding enterprise-grade features and reducing operational complexity.

dbt: dbt is used for transforming data within data warehouse. 

Dataflow: Dataflow is managed Apache Beam on GCP. I have used it to pull data from Pub/Sub and dump data into 
BigQuery after validating incoming messages and transforming it.

### Architecture:

### Flow:
Pipeline flow for batch data load is as follows: I uploaded CSVs into GCS buckets and directly using bucket I created
BQ raw tables. Then using Airflow dag and using dbt I created staging tables and prod tables incrementally. 
Basically, following Zach's suggested practice(use same query for backfill and daily load) I loaded historic data.
I have also implemented a check(shortCircuitOperator), if order is available for a day then only dag runs.
I have also used WAP pattern in dbt.

For real-time updated, I created one Pub/Sub topic(olist_orders_topic) and pushed the JSON message to it containing 
information about order ,order items and payment information. This I had to create since there is no API for it. 
Once message is in topic, I have one subscription(olist_orders_subscription) which is notified of message. 
At the other end I have one dataflow job which constantly pulls message from subscription and once message arrives,
it transforms and validate the message and write the corresponding tables.

I am updating orders, order_items and order_payments table in real-time. I will soon have one dashboard that will pull
data in real-time from orders table.

I will have order updates message as well from Pub/Sub in the future. Currently, I am only creating orders.

#### Tasks in Dag
1. daily_dag - This dag is a full dbt build dag which builds all tables once in a day.

Other dags will be added in future to further enhance data warehouse. i.e. combine and update offline data of customers,

#### DBT tests
* I have incorporated several DBT tests that will help in maintaining data quality
* Since it is a e-comm use case where we have to work with data uncertainty, I don't have much test cases 
other than null checks but in future I will write unit test cases.

### Next steps

* Currently, I don't have extensive dashboard only two graphs, I plan to create full-fledged interactive dashboard.
* Incorporate ML features table in the pipeline(as soon as dim tables are updated features also get the updates).
* Move initial transformation to the Spark using Iceberg( Create Iceberg tables from CSVs stored in Bucket ...)
* Enhance pipeline to update dim tables separately
* Create wide range of Pub/Sub messages and based on event_type update the tables( can have message to update order status
, can have message to update other tables.)
* Add more tests in dbt to enhance the robustness of data.

# Project Contents

- dags: This folder contains the Python files for your Airflow DAGs.
  - `daily_dag.py`: This DAG uses BashOperator and DbtTaskGroup to perform its operations.
- dbt_project: This folder contains the dbt project.
- Dockerfile: This file contains instructions to install libs which are required to execute our pipeline, dbt-core, dbt-bigquery etc.
- include: This folder contains any additional files that you want to include as part of your project. In this example, constants.py includes configuration for your Cosmos project.
- requirements.txt: Install Python packages needed for your project by adding them to this file.
- streaming: This folder contains code for real-time pipeline.
    * pubsub.py: pushes message to GCP Pub/Sub topic
    * streaming_job: contains code for Dataflow code which parsed message from Pub/Sub subscription and processes it.
    * setup: this file is required for Dataflow job
    * generate_order: right now I don't have API endpoint to fetch orders from APP, so I create order in the file.

Screenshots: 

Tableau Dashboard:
![img.png](img.png)

Airflow backfill: 
![img_1.png](img_1.png)

Astronomer Instant Daily: 
![img_2.png](img_2.png)

![img_3.png](img_3.png)

BigQuery:

![img_4.png](img_4.png)

Dataflow: 

Below commands, I used to publish messages and deploy dataflow pipeline: 

* Python3 pubsub.py
* python3 streaming_job.py \
    --runner DataflowRunner \
    --project capstone-project-451604 \
    --region us-central1 \
    --staging_location gs://dataflow-artifacts-capstone/staging \
    --temp_location gs://dataflow-artifacts-capstone/temp \
    --job_name olist-streaming-dataflow \
    --setup_file=./setup.py \
    --max_num_workers=2 \
    --dataflow_service_options=streaming_mode_at_least_once \
    --streaming
* python3 streaming_job.py \
  --project=capstone-project-451604 \
  --runner=DirectRunner \
  --input_subscription=projects/capstone-project-451604/subscriptions/olist_orders_sub \
  --streaming

![img_5.png](img_5.png)


This template is borrowed from Tyler and Lokesh.