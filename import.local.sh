PGPASSWORD=postgres pg_dump\
  -U postgres\
  -h localhost\
  -d marshall\
  -p 15432\
  --schema=public\
  -t '"public"."companies"'\
  -t '"public"."companies_users"'\
  -t '"public"."document_revisions"'\
  -t '"public"."documents"'\
  -t '"public"."facilities"'\
  -t '"public"."folders"'\
  -t '"public"."locations"'\
  -t '"public"."locations_organizations"'\
  -t '"public"."locations_users"'\
  -t '"public"."organizations"'\
  -t '"public"."organizations_users"'\
  -t '"public"."projects"'\
  -t '"public"."users"'\
  --file="dump/final.sql"\
  --data-only\
;

PGPASSWORD=postgres psql\
  -h localhost\
  -p 5432\
  -d marshall\
  -U postgres\
  -f dump/final.sql\
;
