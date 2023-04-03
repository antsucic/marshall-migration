PGPASSWORD=postgres pg_dump\
  -U postgres\
  -h localhost\
  -d marshall\
  -p 5432\
  --schema=public\
  --file="dump/initial.sql"\
  --clean\
;

PGPASSWORD=postgres psql\
  -h localhost\
  -p 15432\
  -d marshall\
  -U postgres\
  -f dump/initial.sql\
;
