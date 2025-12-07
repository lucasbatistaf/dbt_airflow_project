# DBT Data Modelling

### This folder contains the dbt code that builds the data modelling

- Staging
    - Points to the data warehouse locations, making the source tables manageble for the rest of the project.
    - Contains none or light transformations and the column selection from raw data.
- Intermediate
    - Serve as a preparation ground for the aggregation layer.
    - Contains heavy transformation and data cleaning.
- Marts
    - Aggregation layer, used for final stage tables and late data modelling stage, such as Star Schema creation.
    - Contains heavy JOIN usage, Star Schema and final Data Modelling


---

### Raw tables and Star Schema

- Raw tables

![raw database](https://github.com/lucasbatistaf/dbt_airflow_project/blob/main/images/raw_database.png)


Final modelling: Star Schema, and the Fact and Dimension tables

![fact and dim database](https://github.com/lucasbatistaf/dbt_airflow_project/blob/main/images/fact_dim_database.png)
