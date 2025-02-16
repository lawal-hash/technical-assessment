Sales ELT
========
<div align="center">
   <img alt="Static Badge" src="https://img.shields.io/badge/Python%09-white?logo=python">
   <img alt="Static Badge" src="https://img.shields.io/badge/PostgreSQL%09-white?logo=postgresql">
   <img alt="Static Badge" src="https://img.shields.io/badge/dbt%09-white?logo=dbt">
   <img alt="Static Badge" src="https://img.shields.io/badge/Apache%20Airflow%20-white?logo=apacheairflow&logoColor=green">
   <img alt="Static Badge" src="https://img.shields.io/badge/Docker%20-white?logo=docker">
   <img alt="Static Badge" src="https://img.shields.io/badge/Git%09-white?logo=git">
</div>

![pipeline](images/test.png)

Welcome to Astronomer! This project was generated after you ran 'astro dev init' using the Astronomer CLI. This readme describes the contents of the project, as well as how to run Apache Airflow on your local machine.

Project Contents
================

Your Astro project contains the following files and folders:

- dags: This folder contains the Python files for your Airflow DAGs.
    - `ingestion`: This DAG  consist to two tasks `create_task` which generate DDL for the table and `extract_data` which copies the content of the csv file into postgresql. The `extract_data` task uses the TaskFlow API to define tasks in Python, and dynamic task mapping to dynamically load csv file into sql.
    - `transform`: This DAG is a dbt project with various tasks. These tasks are dbt models.
- Dockerfile: This file contains a versioned Astro Runtime Docker image that provides a differentiated Airflow experience. If you want to execute other commands or overrides at runtime, specify them here.
- include: This folder contains any additional files that you want to include as part of your project. It is empty by default.
- packages.txt: Install OS-level packages needed for your project by adding them to this file. It is empty by default.
- requirements.txt: Install Python packages needed for your project by adding them to this file. It is empty by default.
- plugins: Add custom or community plugins for your project to this file. It is empty by default.
- airflow_settings.yaml: Use this local-only file to specify Airflow Connections, Variables, and Pools instead of entering them in the Airflow UI as you develop DAGs in this project.

Deploy Your Project Locally
===========================

1. Start Airflow on your local machine by running 'astro dev start'.

This command will spin up 4 Docker containers on your machine, each for a different Airflow component:

- Postgres: Airflow's Metadata Database
- Webserver: The Airflow component responsible for rendering the Airflow UI
- Scheduler: The Airflow component responsible for monitoring and triggering tasks
- Triggerer: The Airflow component responsible for triggering deferred tasks

2. Verify that all 4 Docker containers were created by running 'docker ps'.

Note: Running 'astro dev start' will start your project with the Airflow Webserver exposed at port 8080 and Postgres exposed at port 5432. If you already have either of those ports allocated, you can either [stop your existing Docker containers or change the port](https://www.astronomer.io/docs/astro/cli/troubleshoot-locally#ports-are-not-available-for-my-local-airflow-webserver).

3. Access the Airflow UI for your local Airflow project. To do so, go to http://localhost:8080/ and log in with 'admin' for both your Username and Password.

You should also be able to access your Postgres Database at 'localhost:5432/postgres'.

Deploy Your Project to Astronomer
=================================

If you have an Astronomer account, pushing code to a Deployment on Astronomer is simple. For deploying instructions, refer to Astronomer documentation: https://www.astronomer.io/docs/astro/deploy-code/

Contact
=======

The Astronomer CLI is maintained with love by the Astronomer team. To report a bug or suggest a change, reach out to our support.
