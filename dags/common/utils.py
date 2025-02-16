import pandas as pd
from airflow.decorators import task
from sqlalchemy import create_engine


@task
def extract_data(table_name):
    engine = create_engine("postgresql://postgres:postgres@postgres/postgres")
    path = f"dags/data/{table_name}.csv"
    df = pd.read_csv(path, sep=",", index_col=False)
    df.to_sql(table_name, con=engine, if_exists="replace", index=False, schema="sales")


@task
def read_table():
    """Return list of tables names to extract"""
    return [
        "customers",
        "products",
        "transactions",
    ]
