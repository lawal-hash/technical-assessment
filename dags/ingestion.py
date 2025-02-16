import sys

sys.path.append("common")
from datetime import datetime

from airflow.decorators import task_group
from airflow.models.dag import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from common.utils import extract_data

DAG_ID = "ingestion"

with DAG(
    dag_id=DAG_ID,
    start_date=datetime(2025, 2, 2),
    schedule="@daily",
    catchup=False,
) as dag:

    create_task = SQLExecuteQueryOperator(
        task_id=f"create_tables",
        sql=f"sql/create_tables/create.sql",
        conn_id="postgres_conn_id",
    )

    @task_group
    def load_data_to_db(table_name):
        extract_data(table_name)

    create_task >> extract_data.expand(
        table_name=[
            "customers",
            "products",
            "transactions",
        ]
    )
