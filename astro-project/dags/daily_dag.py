from datetime import datetime, timedelta

from airflow.decorators import dag
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator
from cosmos import ProfileConfig

PATH_TO_DBT_PROJECT = '/usr/local/airflow/dbt_project'
profile_config = ProfileConfig(
    profile_name="my_dbt_project",
    target_name="dev",
    profiles_yml_filepath="/usr/local/airflow/dbt_project/profiles.yml",
)
start_date = datetime(2016, 9, 6)
default_args = {
    "owner": "Dhruval Patel",
    "retries": 0,
    "execution_timeout": timedelta(hours=1),
    "start_date": start_date
}
@dag(
    start_date=start_date,
    schedule='0 23 * * *',
    catchup=True,
    default_args=default_args,
    max_active_runs=1,
)
def daily_dbt_build_dag():
    """This dag builds whole project daily. """
    pre_dbt_workflow = EmptyOperator(task_id="pre_dbt_workflow")
    ds = '{{ ds }}'

    dbt_build = BashOperator(
        task_id='dbt_build',
        bash_command=f"/usr/local/airflow/dbt_venv/bin/dbt build --vars '{{'start_date': {ds}}}'",
        cwd=PATH_TO_DBT_PROJECT,
    )

    post_dbt_workflow = EmptyOperator(task_id="post_dbt_workflow", trigger_rule="all_done")

    pre_dbt_workflow >> dbt_build >> post_dbt_workflow

daily_dbt_build_dag()


# Below code is used to back fill the tables

# @dag(
#     start_date=start_date,
#     schedule='@daily',
#     catchup=False,
#     default_args=default_args,
#     tags=["capstone"]
# )
# def dbt_dag_cosmos_DbtTaskGroup():
#     pre_dbt_workflow = EmptyOperator(task_id="pre_dbt_workflow")
    # is_valid_date_check = ShortCircuitOperator(
    #     task_id='is_market_day_check',
    #     python_callable=is_market_day,
    #     op_kwargs={'date': ds},  # Replace with dynamic value if needed
    #     provide_context=True
    # )

    # def check_date_in_view(**kwargs):
    #     # Get the execution date (ds) from Airflow context
    #     print('---- kwargs: ', kwargs)
    #     execution_date = kwargs['ds']
    #
    #     # Set up BigQuery Hook
    #     bq_hook = BigQueryHook(
    #         gcp_conn_id="google_cloud_default",
    #     )
    #
    #     # Query the valid_date view
    #     query = f"""
    #     SELECT COUNT(*) > 0 AS date_exists
    #     FROM `capstone-project-451604.capstone_dataset.valid_dates`
    #      WHERE date_m = DATE('2016-09-06')
    #     """
    #
    #     print('---- ',query)
    #
    #     result = bq_hook.get_pandas_df(sql=query)
    #     print('---- ',result)
    #     return result['date_exists'].iloc[0]
    #
    # is_valid_date_check = ShortCircuitOperator(
    #     task_id="check_start_date",
    #     python_callable=check_date_in_view,
    #     provide_context=True,
    # )
#     dbt_run_staging = DbtTaskGroup(
#         group_id="olist_ecom_fact_sales",
#         project_config=ProjectConfig(PATH_TO_DBT_PROJECT,
#                                      dbt_vars={"start_date": "{{ ds }}"}, ),
#         profile_config=profile_config,
#         render_config=RenderConfig(
#             select=["+fact_sales"],
#         ),
#         # operator_args={'start_date': str(datetime(2016, 9, 13))},
#         execution_config=venv_execution_config,
#         default_args={"retries": 2},
#     )
#
#     # Post DBT workflow task
#     post_dbt_workflow = EmptyOperator(task_id="post_dbt_workflow", trigger_rule="all_done")
#
#     # Define task dependencies
#     pre_dbt_workflow >> is_valid_date_check >> dbt_run_staging >> post_dbt_workflow
#
# dbt_dag_cosmos_DbtTaskGroup()