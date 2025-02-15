import os
from datetime import datetime
from pathlib import Path

from cosmos import DbtDag, ProjectConfig, ProfileConfig,ExecutionConfig
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
        "install_deps": True,  # install any necessary dependencies before running any dbt command
        "full_refresh": True,  # used only in dbt commands that support this flag
    },
    # normal dag parameters
    schedule_interval="@daily",
    start_date=datetime(2025, 2, 14),
    catchup=False,
    dag_id="sales_transformations",
    default_args={"retries": 2},
)
