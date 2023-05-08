DROP TABLE IF EXISTS transform.companies_users_production;
DROP TABLE IF EXISTS transform.companies_users_production_added;

CREATE TABLE transform.companies_users_production (
    id BIGINT
    , company_id BIGINT
    , user_id BIGINT
);

CREATE TABLE transform.companies_users_production_added (
    company_id BIGINT
    , user_id BIGINT
);
