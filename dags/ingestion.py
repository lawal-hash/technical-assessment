from datetime import datetime
from airflow.decorators import task,task_group
from airflow.models.dag import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator

DAG_ID = "ingestion"

with DAG(
    dag_id=DAG_ID,
    start_date=datetime(2025, 2, 2),
    schedule="@once",
    catchup=False,
) as dag:
    
    @task
    def read_table():
        """ Return list of tables names to extract """
        return [
            "customers",
            "products",
            "sales_transactions",
        ]


    create_task = SQLExecuteQueryOperator(
        task_id= f"create_tables",
        sql= f"sql/create_tables/create.sql",
        conn_id="postgres_conn_id"
        )
        
       
    extract_task = SQLExecuteQueryOperator(
            task_id= "extract_customers_data",
            sql= "sql/extract_data/customers.sql",   
            conn_id="postgres_conn_id"         
            )

    create_task >> extract_task
