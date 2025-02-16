import os
from datetime import datetime

from cosmos import DbtDag, ExecutionConfig, ProfileConfig, ProjectConfig
from cosmos.profiles import PostgresUserPasswordProfileMapping

airflow_home = os.environ["AIRFLOW_HOME"]

profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=PostgresUserPasswordProfileMapping(
        conn_id="postgres_conn_id",
        profile_args={"schema": "public"},
    ),
)

dbt_dag = DbtDag(
    # dbt/cosmos-specific parameters
    project_config=ProjectConfig(
        f"{airflow_home}/dags/dbt/sales",
    ),
    profile_config=profile_config,
    execution_config=ExecutionConfig(
        dbt_executable_path=f"{airflow_home}/dbt_venv/bin/dbt",
    ),
    operator_args={
        "install_deps": True,  
        "full_refresh": True,  
    },
    # normal dag parameters
    schedule_interval="@daily",
    start_date=datetime(2025, 2, 14),
    catchup=False,
    dag_id="sales_transformations",
    default_args={"retries": 2},
)
