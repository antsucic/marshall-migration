PGPASSWORD=postgres pg_dump\
  -U postgres\
  -h localhost\
  -d marshall\
  -p 15432\
  --schema=public\
  --file="dump/final.sql"\
  --clean\
  --if-exists\
;

PGPASSWORD=postgres psql\
  -h localhost\
  -p 5432\
  -d marshall\
  -U postgres\
  -f dump/final.sql\
;
