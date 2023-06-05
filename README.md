# MARSHAL MIGRATION


## Description
Legacy data is stored in databases without any relations. Data is spread trough multiple databases. There is a lot of data duplications, tables with multiple entities and data is queried via unoptimized views with multiple embedded select statements.  This project was created to migrate Marshall project legacy databases from Microsoft SQL Server to new PostgreSQL unified database with more normalized structure.

This is not a single time run app. It can be run multiple times, this app will find updated / new data from legacy database and push only the changes to the new target database. To achieve this we are adding legacy ids to our new tables which we can use to track the origin of information.

Goal of this project is to be a temporary bridge between the legacy and new app while legacy app is still in use simultaneously with new Marshall app. At one point the legacy app will be completely out of use and shut down. At that time, this project can be closed or used as an example solution for similar issues.

## Installation
For local use, you can run docker container and import data to database from a dump file that can be provided separately (Ask a colleague for the dump file).

- Create a `.env` file using the `.env.example`- For development purposes you can just copy as is, adjust according to your needs.

- Run the following command to build containers:
```sh
docker compose up -d
```

- Run the following command to enter app container:
```sh
docker compose exec app bash
```

- Once you are ready and have your dump file provided by colleague, run the following command:

```sh
PGPASSWORD={password} psql -h {host} -p {port} -d {database} -U {user} -f {path/to/file.sql} -v ON_ERROR_STOP=1
```
> **_NOTE:_** Replace {parameters} with credentials to your database and sql dump file. If you want to run this without docker, make sure you have psql installed locally.


## Usage

Project contains couple of main scripts preforming different parts of the migration job.

### Prepare database

To prepare database for ETL run you need to create legacy schemas and tables in PostgreSQL database.

- ```ruby app/prepare.rb```

### Reload data

This script loads data from MS SQL Server to PostgreSQL structure as-is with same table and column names as legacy database and data split into schemas as the original data is split in multiple databases.

- ```ruby app/reload.rb```

> **_NOTE:_** Do not run this locally unless you configure MS SQL Server databases locally and copy database from legacy source.

### Run ETL scripts

This is the main process in charge of calculating differences between databases and loading them to the target database.

- ```ruby app/run.rb```

### Run report script

This is used to get report on amount of data updated / loaded from the last ETL script run.

- ```ruby app/report.rb```

### Run full synchronization

This script runs all of the scripts above, and is generally what you will be using for your production setup.

- ```ruby app/sync.rb```
