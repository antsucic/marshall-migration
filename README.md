### Load local app database values to local staging database
Requires pg_dump & psql locally

```cleanup.local.sh```

### Reload data from production MS SQL Server database to local Postgres database
```docker compose exec app ruby app/reload.rb```

### Run ETL scripts
```docker compose exec app ruby app/run.rb```

### Import data to local app database
Requires pg_dump & psql locally

```import.local.sh```

### Deployment

Make a production/staging/uat/etl version of import.local.sh to import processed data to specified environment.
Same goes for the cleanup script if you wish to copy specific database state to local database.
