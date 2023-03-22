create table public.schema_migrations
(
    version varchar not null
        primary key
);

alter table public.schema_migrations
    owner to postgres;

create table public.ar_internal_metadata
(
    key        varchar      not null
        primary key,
    value      varchar,
    created_at timestamp(6) not null,
    updated_at timestamp(6) not null
);

alter table public.ar_internal_metadata
    owner to postgres;

create table public.users
(
    id                     bigserial
        primary key,
    email                  varchar,
    created_at             timestamp(6)                          not null,
    updated_at             timestamp(6)                          not null,
    first_name             varchar,
    role                   varchar,
    permissions            jsonb[] default '{}'::jsonb[],
    status                 varchar default 'pending'::character varying,
    encrypted_password     varchar default ''::character varying not null,
    reset_password_token   varchar,
    reset_password_sent_at timestamp,
    remember_created_at    timestamp,
    confirmation_token     varchar,
    confirmed_at           timestamp,
    confirmation_sent_at   timestamp,
    unconfirmed_email      varchar,
    last_name              varchar,
    sign_in_count          integer default 0                     not null,
    current_sign_in_at     timestamp,
    last_sign_in_at        timestamp,
    current_sign_in_ip     varchar,
    last_sign_in_ip        varchar,
    phone                  varchar,
    mobile_phone           varchar
);

alter table public.users
    owner to postgres;

create index index_users_on_first_name
    on public.users (first_name);

create index index_users_on_role
    on public.users (role);

create index index_users_on_status
    on public.users (status);

create index index_users_on_permissions
    on public.users using gin (permissions);

create unique index index_users_on_email
    on public.users (email);

create unique index index_users_on_reset_password_token
    on public.users (reset_password_token);

create table public.projects
(
    id          bigserial
        primary key,
    created_at  timestamp(6)                                not null,
    updated_at  timestamp(6)                                not null,
    name        varchar,
    number      varchar,
    description text,
    status      varchar default 'active'::character varying not null,
    facility_id integer
);

alter table public.projects
    owner to postgres;

create index index_projects_on_name
    on public.projects (name);

create index index_projects_on_number
    on public.projects (number);

create index index_projects_on_status
    on public.projects (status);

create index index_projects_on_facility_id
    on public.projects (facility_id);

create table public.locations
(
    id          bigserial
        primary key,
    address     varchar,
    city        varchar,
    state       varchar,
    country     varchar,
    postal_code varchar,
    created_at  timestamp(6) not null,
    updated_at  timestamp(6) not null
);

alter table public.locations
    owner to postgres;

create table public.organizations
(
    id         bigserial
        primary key,
    name       varchar,
    created_at timestamp(6) not null,
    updated_at timestamp(6) not null
);

alter table public.organizations
    owner to postgres;

create unique index index_organizations_on_name
    on public.organizations (name);

create table public.companies
(
    id                bigserial
        primary key,
    location_id       bigint                    not null
        constraint fk_rails_1e99f51bd6
            references public.locations,
    name              varchar,
    phone             varchar,
    status            varchar,
    created_at        timestamp(6)              not null,
    updated_at        timestamp(6)              not null,
    custom_attributes jsonb default '[]'::jsonb not null
);

alter table public.companies
    owner to postgres;

create index index_companies_on_location_id
    on public.companies (location_id);

create unique index index_companies_on_name
    on public.companies (name);

create index index_companies_on_status
    on public.companies (status);

create index index_companies_on_custom_attributes
    on public.companies using gin (custom_attributes);

create table public.facilities
(
    id                  bigserial
        primary key,
    company_id          bigint       not null
        constraint fk_rails_e9419f453f
            references public.companies,
    location_id         bigint       not null
        constraint fk_rails_4d0a4ebac5
            references public.locations,
    name                varchar,
    facility_type       varchar,
    status              varchar,
    created_at          timestamp(6) not null,
    updated_at          timestamp(6) not null,
    image_identificator varchar
);

alter table public.facilities
    owner to postgres;

create index index_facilities_on_company_id
    on public.facilities (company_id);

create index index_facilities_on_location_id
    on public.facilities (location_id);

create index index_facilities_on_name
    on public.facilities (name);

create index index_facilities_on_facility_type
    on public.facilities (facility_type);

create index index_facilities_on_status
    on public.facilities (status);

create table public.disciplines
(
    id         bigserial
        primary key,
    name       varchar,
    created_at timestamp(6) not null,
    updated_at timestamp(6) not null
);

alter table public.disciplines
    owner to postgres;

create unique index index_disciplines_on_name
    on public.disciplines (name);

create table public.user_action_logs
(
    id           bigserial
        primary key,
    logable_type varchar      not null,
    logable_id   bigint       not null,
    user_id      bigint       not null
        constraint fk_rails_cfc9dc539f
            references public.users,
    action       varchar      not null,
    created_at   timestamp(6) not null,
    updated_at   timestamp(6) not null
);

alter table public.user_action_logs
    owner to postgres;

create index index_user_action_logs_on_logable
    on public.user_action_logs (logable_type, logable_id);

create index index_user_action_logs_on_user_id
    on public.user_action_logs (user_id);

create index index_user_action_logs_on_action
    on public.user_action_logs (action);

create table public.contacts
(
    id              bigserial
        primary key,
    organization_id bigint       not null
        constraint fk_rails_b7db93c1c3
            references public.organizations,
    project_id      bigint       not null
        constraint fk_rails_b0485f0dbc
            references public.projects,
    name            varchar,
    email           varchar,
    phone           varchar,
    mobile_phone    varchar,
    created_at      timestamp(6) not null,
    updated_at      timestamp(6) not null
);

alter table public.contacts
    owner to postgres;

create index index_contacts_on_organization_id
    on public.contacts (organization_id);

create index index_contacts_on_project_id
    on public.contacts (project_id);

create table public.folders
(
    id              bigserial
        primary key,
    parent_id       bigint
        constraint fk_rails_58e285f76e
            references public.folders,
    name            varchar      not null,
    created_at      timestamp(6) not null,
    updated_at      timestamp(6) not null,
    folderable_type varchar,
    folderable_id   bigint
);

alter table public.folders
    owner to postgres;

create index index_folders_on_name
    on public.folders (name);

create index index_folders_on_folderable
    on public.folders (folderable_type, folderable_id);

create index index_folders_on_parent_id
    on public.folders (parent_id);

create table public.documents
(
    id                bigserial
        primary key,
    item_number       varchar,
    status            varchar default 'active'::character varying not null,
    document_type     varchar                                     not null,
    created_at        timestamp(6)                                not null,
    updated_at        timestamp(6)                                not null,
    documentable_type varchar,
    documentable_id   bigint,
    subproject        varchar
);

alter table public.documents
    owner to postgres;

create index index_documents_on_status
    on public.documents (status);

create index index_documents_on_document_type
    on public.documents (document_type);

create index index_documents_on_documentable
    on public.documents (documentable_type, documentable_id);

create index index_documents_on_item_number
    on public.documents (item_number);

create table public.document_revisions
(
    id                  bigserial
        primary key,
    document_id         bigint                                      not null
        constraint fk_rails_35622b6831
            references public.documents,
    name                varchar                                     not null,
    status              varchar default 'active'::character varying not null,
    description         text,
    created_at          timestamp(6)                                not null,
    updated_at          timestamp(6)                                not null,
    document_attributes jsonb   default '{}'::jsonb                 not null,
    revision            varchar,
    discipline          varchar,
    image_identificator varchar,
    is_old              boolean default false                       not null,
    folder_id           bigint
        constraint fk_rails_b808d5116d
            references public.folders
);

alter table public.document_revisions
    owner to postgres;

create index index_document_revisions_on_document_id
    on public.document_revisions (document_id);

create index index_document_revisions_on_name
    on public.document_revisions (name);

create index index_document_revisions_on_status
    on public.document_revisions (status);

create index index_document_revisions_on_document_attributes
    on public.document_revisions using gin (document_attributes);

create index index_document_revisions_on_folder_id
    on public.document_revisions (folder_id);

create table public.user_registrations
(
    id         bigserial
        primary key,
    user_id    bigint       not null
        constraint fk_rails_899ff21c18
            references public.users,
    token      varchar,
    expires_at timestamp,
    created_by integer,
    created_at timestamp(6) not null,
    updated_at timestamp(6) not null
);

alter table public.user_registrations
    owner to postgres;

create index index_user_registrations_on_user_id
    on public.user_registrations (user_id);

create unique index index_user_registrations_on_token
    on public.user_registrations (token);

create table public.organizations_users
(
    organization_id bigint not null,
    user_id         bigint not null,
    id              bigserial
        primary key,
    phone           varchar,
    mobile_phone    varchar,
    location_id     bigint not null
        constraint fk_rails_3e144bfc79
            references public.locations
);

alter table public.organizations_users
    owner to postgres;

create index index_organizations_users_on_organization_id_and_user_id
    on public.organizations_users (organization_id, user_id);

create index index_organizations_users_on_user_id_and_organization_id
    on public.organizations_users (user_id, organization_id);

create index index_organizations_users_on_location_id
    on public.organizations_users (location_id);

create table public.locations_users
(
    location_id  bigint not null,
    user_id      bigint not null,
    id           bigserial
        primary key,
    phone        varchar,
    mobile_phone varchar
);

alter table public.locations_users
    owner to postgres;

create index index_locations_users_on_location_id_and_user_id
    on public.locations_users (location_id, user_id);

create index index_locations_users_on_user_id_and_location_id
    on public.locations_users (user_id, location_id);

create table public.locations_organizations
(
    location_id     bigint not null,
    organization_id bigint not null
);

alter table public.locations_organizations
    owner to postgres;

create index locations_organizations_index
    on public.locations_organizations (location_id, organization_id);

create index organizations_locations_index
    on public.locations_organizations (organization_id, location_id);

create table public.companies_users
(
    company_id   bigint not null,
    user_id      bigint not null,
    id           bigserial
        primary key,
    phone        varchar,
    mobile_phone varchar
);

alter table public.companies_users
    owner to postgres;

create index index_companies_users_on_company_id_and_user_id
    on public.companies_users (company_id, user_id);

create index index_companies_users_on_user_id_and_company_id
    on public.companies_users (user_id, company_id);

create table public.access_permissions
(
    id              bigserial
        primary key,
    accessable_type varchar      not null,
    accessable_id   bigint       not null,
    user_id         bigint       not null
        constraint fk_rails_46e193a0c6
            references public.users,
    creator_id      integer,
    created_at      timestamp(6) not null,
    updated_at      timestamp(6) not null
);

alter table public.access_permissions
    owner to postgres;

create index index_access_permissions_on_accessable
    on public.access_permissions (accessable_type, accessable_id);

create index index_access_permissions_on_user_id
    on public.access_permissions (user_id);

create table public.allowlisted_jwts
(
    id      bigserial
        primary key,
    jti     varchar   not null,
    aud     varchar,
    exp     timestamp not null,
    user_id bigint    not null
        constraint fk_rails_77afa78cd5
            references public.users
            on delete cascade
);

alter table public.allowlisted_jwts
    owner to postgres;

create index index_allowlisted_jwts_on_user_id
    on public.allowlisted_jwts (user_id);

create unique index index_allowlisted_jwts_on_jti
    on public.allowlisted_jwts (jti);

create table public.active_storage_blobs
(
    id           bigserial
        primary key,
    key          varchar   not null,
    filename     varchar   not null,
    content_type varchar,
    metadata     text,
    service_name varchar   not null,
    byte_size    bigint    not null,
    checksum     varchar   not null,
    created_at   timestamp not null
);

alter table public.active_storage_blobs
    owner to postgres;

create unique index index_active_storage_blobs_on_key
    on public.active_storage_blobs (key);

create table public.active_storage_attachments
(
    id          bigserial
        primary key,
    name        varchar   not null,
    record_type varchar   not null,
    record_id   bigint    not null,
    blob_id     bigint    not null
        constraint fk_rails_c3b3935057
            references public.active_storage_blobs,
    created_at  timestamp not null
);

alter table public.active_storage_attachments
    owner to postgres;

create index index_active_storage_attachments_on_blob_id
    on public.active_storage_attachments (blob_id);

create unique index index_active_storage_attachments_uniqueness
    on public.active_storage_attachments (record_type, record_id, name, blob_id);

create table public.active_storage_variant_records
(
    id               bigserial
        primary key,
    blob_id          bigint  not null
        constraint fk_rails_993965df05
            references public.active_storage_blobs,
    variation_digest varchar not null
);

alter table public.active_storage_variant_records
    owner to postgres;

create unique index index_active_storage_variant_records_uniqueness
    on public.active_storage_variant_records (blob_id, variation_digest);

create table public.document_custom_attributes
(
    id            bigserial
        primary key,
    company_id    bigint                                             not null
        constraint fk_rails_3b43abba67
            references public.companies,
    name          varchar,
    document_type varchar default 'uploaded_file'::character varying not null,
    is_required   boolean default false                              not null,
    is_deleted    boolean default false                              not null,
    created_at    timestamp(6)                                       not null,
    updated_at    timestamp(6)                                       not null
);

alter table public.document_custom_attributes
    owner to postgres;

create index index_document_custom_attributes_on_company_id
    on public.document_custom_attributes (company_id);


