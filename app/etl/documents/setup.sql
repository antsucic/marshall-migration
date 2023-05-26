DROP TABLE IF EXISTS staging.documents;
DROP TABLE IF EXISTS staging.document_file_sources;
DROP TABLE IF EXISTS staging.document_subprojects;
DROP TABLE IF EXISTS staging.document_revision_numbers;
DROP TABLE IF EXISTS staging.document_disciplines;
DROP TABLE IF EXISTS staging.document_numbers;
DROP TABLE IF EXISTS staging.document_types;
DROP TABLE IF EXISTS staging.document_issue_names;
DROP TABLE IF EXISTS staging.document_issue_dates;
DROP TABLE IF EXISTS staging.document_discipline_map;
DROP TABLE IF EXISTS staging.document_attributes;
DROP TABLE IF EXISTS transform.document_attributes;
DROP TABLE IF EXISTS transform.documents_legacy CASCADE;
DROP TABLE IF EXISTS transform.document_revisions_legacy;
DROP TABLE IF EXISTS transform.documents_production;
DROP TABLE IF EXISTS transform.documents_production_added;
DROP TABLE IF EXISTS transform.documents_production_updated;
DROP TABLE IF EXISTS transform.document_revisions_production;
DROP TABLE IF EXISTS transform.document_revisions_production_added;
DROP TABLE IF EXISTS transform.document_revisions_production_updated;
DROP VIEW IF EXISTS transform.check_dates CASCADE;
DROP FUNCTION IF EXISTS transform.updated_documents_in;
DROP PROCEDURE IF EXISTS transform.insert_document_updates();

CREATE TABLE staging.documents (
    legacy_id VARCHAR(36)
    , legacy_folder_id VARCHAR(36)
    , legacy_documentable_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "name" VARCHAR
    , status VARCHAR
    , description VARCHAR
    , is_not_old VARCHAR
    , file_source INT
    , file_path VARCHAR
    , file_name VARCHAR
    , created_at TIMESTAMP(6) NOT NULL
    , updated_at TIMESTAMP(6) NOT NULL
);

CREATE INDEX ON staging.documents (legacy_id);
CREATE INDEX ON staging.documents (legacy_documentable_id);
CREATE INDEX ON staging.documents (legacy_source);

CREATE TABLE staging.document_file_sources (
    priority INT
    , name VARCHAR
);

INSERT INTO staging.document_file_sources
    (priority, name)
VALUES
    (1, 'SYS_DEFAULT_S3_DEVICE'),
    (2, 'SYS_DEFAULT_STORAGE_DEVICE'),
    (3, 'SYS_DEFAULT_ARCHIVE'),
    (4, 'SYS_DEFAULT_MOBILE_DEVICE')
;

CREATE TABLE staging.document_subprojects (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR
);

CREATE INDEX ON staging.document_subprojects (legacy_id);
CREATE INDEX ON staging.document_subprojects (legacy_source);
CREATE INDEX ON staging.document_subprojects (value);

CREATE TABLE staging.document_revision_numbers (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR
);

CREATE INDEX ON staging.document_revision_numbers (legacy_id);
CREATE INDEX ON staging.document_revision_numbers (legacy_source);
CREATE INDEX ON staging.document_revision_numbers (value);

CREATE TABLE staging.document_disciplines (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR
);

CREATE INDEX ON staging.document_disciplines (legacy_id);
CREATE INDEX ON staging.document_disciplines (legacy_source);
CREATE INDEX ON staging.document_disciplines (value);

CREATE TABLE staging.document_numbers (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR
);

CREATE INDEX ON staging.document_numbers (legacy_id);
CREATE INDEX ON staging.document_numbers (legacy_source);
CREATE INDEX ON staging.document_numbers (value);

CREATE TABLE staging.document_types (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR(20)
);

CREATE INDEX ON staging.document_types (legacy_id);
CREATE INDEX ON staging.document_types (legacy_source);
CREATE INDEX ON staging.document_types (value);

CREATE TABLE staging.document_issue_names (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR
);

CREATE INDEX ON staging.document_issue_names (legacy_id);
CREATE INDEX ON staging.document_issue_names (legacy_source);
CREATE INDEX ON staging.document_issue_names (value);

CREATE TABLE staging.document_issue_dates (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR
);

CREATE INDEX ON staging.document_issue_dates (legacy_id);
CREATE INDEX ON staging.document_issue_dates (legacy_source);
CREATE INDEX ON staging.document_issue_dates (value);

CREATE TABLE staging.document_attributes (
    legacy_id VARCHAR(36)
    , legacy_attribute_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" VARCHAR
);

CREATE INDEX ON staging.document_attributes (legacy_id);
CREATE INDEX ON staging.document_attributes (legacy_attribute_id);
CREATE INDEX ON staging.document_attributes (legacy_source);
CREATE INDEX ON staging.document_attributes (value);

CREATE TABLE staging.document_discipline_map (
    legacy_value VARCHAR
    , new_value VARCHAR
);

CREATE INDEX ON staging.document_discipline_map (legacy_value);
CREATE INDEX ON staging.document_discipline_map (new_value);

INSERT INTO staging.document_discipline_map
    (legacy_value, new_value)
VALUES
    ('1987 Signage', 'VENDOR'),
    ('Accessibility', 'ACCESSIBILITY'),
    ('Accessibilty', 'ACCESSIBILITY'),
    ('Acoustics', 'ARCHITECTURAL'),
    ('ADA', 'ACCESSIBILITY'),
    ('ADA Drawings', 'ACCESSIBILITY'),
    ('ADDENDUM NO.', 'ARCHITECTURAL'),
    ('Addendum No. 01', 'ARCHITECTURAL'),
    ('Adjusting-Balance Air Testing', 'MECHANICAL'),
    ('All', 'ARCHITECTURAL'),
    ('Alternates', 'ARCHITECTURAL'),
    ('Anchorage', 'VENDOR'),
    ('Architectural', 'ARCHITECTURAL'),
    ('ArchitecturalArchitectural', 'ARCHITECTURAL'),
    ('Architectural Site', 'ARCHITECTURAL'),
    ('Architectural Tenant', 'ARCHITECTURAL'),
    ('Asbestos', 'ARCHITECTURAL'),
    ('Asbestos Abatement', 'ARCHITECTURAL'),
    ('As-Built', 'ARCHITECTURAL'),
    ('As-Builts', 'ARCHITECTURAL'),
    ('ASC Equipment', 'VENDOR'),
    ('Audio Visual', 'COMMUNICATIONS'),
    ('A/V', 'COMMUNICATIONS'),
    ('A/V Systems', 'COMMUNICATIONS'),
    ('Ball Fields', 'VENDOR'),
    ('Civil', 'CIVIL'),
    ('Civil - ED', 'CIVIL'),
    ('Civil - Hospital', 'CIVIL'),
    ('Civil - Spinning Wheel', 'CIVIL'),
    ('Code Consultant', 'VENDOR'),
    ('Codes', 'VENDOR'),
    ('Communications', 'COMMUNICATIONS'),
    ('ConMed', 'VENDOR'),
    ('Construction Documents', 'ARCHITECTURAL'),
    ('Construction Phasing', 'ARCHITECTURAL'),
    ('Controlled Demolition', 'DEMOLITION'),
    ('Controls', 'COMMUNICATIONS'),
    ('Core & Shell', 'ARCHITECTURAL'),
    ('Datacom', 'COMMUNICATIONS'),
    ('Demolition', 'DEMOLITION'),
    ('Demolition9/17/2010', 'DEMOLITION'),
    ('Design Development', 'ARCHITECTURAL'),
    ('Details', 'ARCHITECTURAL'),
    ('Detention', 'VENDOR'),
    ('Detention Security', 'VENDOR'),
    ('Diagram', 'VENDOR'),
    ('Dietary', 'FOOD_SERVICE'),
    ('Door Control', 'COMMUNICATIONS'),
    ('echanical', 'MECHANICAL'),
    ('Edge of Slab', 'VENDOR'),
    ('Egress/Energy', 'VENDOR'),
    ('Elec Arch', 'ELECTRICAL'),
    ('Electrical', 'ELECTRICAL'),
    ('Electrical Demolition', 'ELECTRICAL'),
    ('Electrical Equipment Anchorage', 'ELECTRICAL'),
    ('Elevator', 'VENDOR'),
    ('ENVIRONMENTAL GRAPHICS', 'VENDOR'),
    ('EP', 'VENDOR'),
    ('Equipment', 'EQUIPMENT'),
    ('Equipment Plan', 'EQUIPMENT'),
    ('Equipment Plans', 'EQUIPMENT'),
    ('Erection', 'VENDOR'),
    ('Erosion', 'CIVIL'),
    ('Erosion Control', 'CIVIL'),
    ('EROSION CONTROL', 'CIVIL'),
    ('Existing', 'ARCHITECTURAL'),
    ('Exterior Framing', 'STRUCTURAL'),
    ('Fa', 'VENDOR'),
    ('Finishes', 'INTERIORS'),
    ('Fire Alarm', 'FIRE_PROTECTION'),
    ('Fire/Life', 'FIRE_PROTECTION'),
    ('Fireproofing', 'VENDOR'),
    ('Fire Protection', 'FIRE_PROTECTION'),
    ('Fire Safety', 'FIRE_PROTECTION'),
    ('Fire/Security', 'FIRE_PROTECTION'),
    ('Fire Sprinkler', 'FIRE_PROTECTION'),
    ('Fire Suppression', 'FIRE_PROTECTION'),
    ('Fite Sprinkler', 'FIRE_PROTECTION'),
    ('Foodservice', 'FOOD_SERVICE'),
    ('Food Service', 'FOOD_SERVICE'),
    ('Food Service/Dietary', 'FOOD_SERVICE'),
    ('Foodservice Equipment', 'FOOD_SERVICE'),
    ('Food Service Equipment', 'FOOD_SERVICE'),
    ('Food Services', 'FOOD_SERVICE'),
    ('Furnishings', 'INTERIORS'),
    ('Furniture', 'INTERIORS'),
    ('Furniture & Equipmen', 'INTERIORS'),
    ('Gas Services', 'PLUMBING'),
    ('General', 'GENERAL_REQUIREMENTS'),
    ('General Information', 'GENERAL_REQUIREMENTS'),
    ('General Requiremee', 'GENERAL_REQUIREMENTS'),
    ('General Requirements', 'GENERAL_REQUIREMENTS'),
    ('General RequirementsGeneral RequirementsGeneral Re', 'GENERAL_REQUIREMENTS'),
    ('Graphics', 'VENDOR'),
    ('Graphics/Signage', 'VENDOR'),
    ('Hardscape', 'LANDSCAPE'),
    ('Healthcare Technolog', 'COMMUNICATIONS'),
    ('Helipad', 'CIVIL'),
    ('Heliport', 'CIVIL'),
    ('HVAC', 'MECHANICAL'),
    ('ical Gas', 'MEDICAL_GAS'),
    ('ICRA', 'VENDOR'),
    ('Imaging', 'VENDOR'),
    ('Imaging Equipment', 'VENDOR'),
    ('Infection Control', 'VENDOR'),
    ('Installation Drawing', 'VENDOR'),
    ('Instrumentation', 'VENDOR'),
    ('Interior Design', 'INTERIORS'),
    ('Interior Designer', 'INTERIORS'),
    ('Interiors', 'INTERIORS'),
    ('Internet', 'COMMUNICATIONS'),
    ('Irrigation', 'LANDSCAPE'),
    ('IT Vendor', 'COMMUNICATIONS'),
    ('kitchen', 'FOOD_SERVICE'),
    ('Kitchen', 'FOOD_SERVICE'),
    ('Kitchen Equipment', 'FOOD_SERVICE'),
    ('Lab Equipment', 'VENDOR'),
    ('Laboratory', 'VENDOR'),
    ('Laboratory Vendor Drawings', 'VENDOR'),
    ('Lab Planning', 'VENDOR'),
    ('Landscape', 'LANDSCAPE'),
    ('Laundry', 'ARCHITECTURAL'),
    ('Life Safety', 'LIFE_SAFETY'),
    ('Lighting', 'ELECTRICAL'),
    ('Lightning Protection', 'ELECTRICAL'),
    ('Low Voltage', 'COMMUNICATIONS'),
    ('Low Voltage/Security', 'COMMUNICATIONS'),
    ('Low Voltage/Telecom', 'COMMUNICATIONS'),
    ('Maquet', 'VENDOR'),
    ('Material Handling', 'VENDOR'),
    ('M&E', 'MECHANICAL'),
    ('M-E', 'MECHANICAL'),
    ('Mechanical', 'MECHANICAL'),
    ('Mechanical Demolition', 'MECHANICAL'),
    ('MECHANICAL/ELECTRICA', 'MECHANICAL'),
    ('Mechanical Equipment Anchorage', 'MECHANICAL'),
    ('Mechanical & Plumbing', 'MECHANICAL'),
    ('Mechanical-Plumbing', 'MECHANICAL'),
    ('Mechanical/Plumbing', 'MECHANICAL'),
    ('Mech-Elec', 'MECHANICAL'),
    ('Mech/Elec/Plumb', 'MECHANICAL'),
    ('MECH, ELECT, PLUMB', 'MECHANICAL'),
    ('Mech-Plumb', 'MECHANICAL'),
    ('Mech/Plumb', 'MECHANICAL'),
    ('Mech/Plumb/Elect', 'MECHANICAL'),
    ('Med Com', 'COMMUNICATIONS'),
    ('Medcomm', 'COMMUNICATIONS'),
    ('Med Comm', 'COMMUNICATIONS'),
    ('Med Gas', 'MEDICAL_GAS'),
    ('MedGas', 'MEDICAL_GAS'),
    ('Medical Communications', 'COMMUNICATIONS'),
    ('Medical Equipmant', 'VENDOR'),
    ('Medical Equipment', 'VENDOR'),
    ('Medical Equipment Anchorage', 'VENDOR'),
    ('Medical Gas', 'MEDICAL_GAS'),
    ('Medical Gases', 'MEDICAL_GAS'),
    ('Mep', 'MECHANICAL'),
    ('MeP', 'MECHANICAL'),
    ('MEP', 'MECHANICAL'),
    ('MEP Utilities', 'MECHANICAL'),
    ('Metal Bldg Systems', 'VENDOR'),
    ('Millwork', 'ARCHITECTURAL'),
    ('Miscellaneous', 'VENDOR'),
    ('Misc. Vendor', 'VENDOR'),
    ('M.O.B.', 'ARCHITECTURAL'),
    ('Modular Casework', 'INTERIORS'),
    ('M & P', 'MECHANICAL'),
    ('M&P', 'MECHANICAL'),
    ('MP', 'MECHANICAL'),
    ('MP Demolition', 'MECHANICAL'),
    ('MPE', 'MECHANICAL'),
    ('Nurse Call', 'COMMUNICATIONS'),
    ('Orientation', 'ARCHITECTURAL'),
    ('Other', 'VENDOR'),
    ('Owner Vendor', 'VENDOR'),
    ('Parking', 'VENDOR'),
    ('Parking Equipment', 'VENDOR'),
    ('Parking Garage', 'VENDOR'),
    ('Parking Layout', 'VENDOR'),
    ('Parking Signage Guidelines', 'VENDOR'),
    ('Parking Signage Guidelines`', 'VENDOR'),
    ('Patient Rooms', 'ARCHITECTURAL'),
    ('PCS System', 'VENDOR'),
    ('P&E', 'PLUMBING'),
    ('Phasing', 'ARCHITECTURAL'), -- PHASING
    ('P&ID', 'PLUMBING'),
    ('Piping Plan', 'PLUMBING'),
    ('Playing Field', 'VENDOR'),
    ('Plumbing', 'PLUMBING'),
    ('Plumbing Demolition', 'PLUMBING'),
    ('Plumbing & Electrical', 'PLUMBING'),
    ('Pneumatic Tube', 'PNEUMATIC_TUBE'),
    ('Pneumatic Tube System', 'PNEUMATIC_TUBE'),
    ('Pool', 'VENDOR'),
    ('Pool Design', 'VENDOR'),
    ('Post Tension', 'STRUCTURAL'),
    ('Precast', 'STRUCTURAL'),
    ('Precast Modular Cells', 'STRUCTURAL'),
    ('Process', 'PLUMBING'),
    ('Process Piping', 'PLUMBING'),
    ('PTS System', 'PNEUMATIC_TUBE'),
    ('Radiology', 'VENDOR'),
    ('rchitectural', 'ARCHITECTURAL'),
    ('Reference', 'ARCHITECTURAL'),
    ('Repairs', 'VENDOR'),
    ('re Protection', 'FIRE_PROTECTION'),
    ('Reroof', 'VENDOR'),
    ('Retaining Wall', 'LANDSCAPE'),
    ('rientation', 'ARCHITECTURAL'),
    ('Roof', 'ARCHITECTURAL'),
    ('Rooftop Landscape', 'LANDSCAPE'),
    ('San-I-Pak', 'VENDOR'),
    ('Security', 'COMMUNICATIONS'),
    ('Security and Fire Alarm', 'COMMUNICATIONS'),
    ('Security Camera', 'COMMUNICATIONS'),
    ('Security Electronics', 'COMMUNICATIONS'),
    ('Security Electronics & Fire Alarm', 'COMMUNICATIONS'),
    ('Security & Fire Alar', 'COMMUNICATIONS'),
    ('Security & Fire Alarm', 'COMMUNICATIONS'),
    ('Security Wall', 'VENDOR'),
    ('SE&FA', 'COMMUNICATIONS'),
    ('Seismic', 'STRUCTURAL'),
    ('Sequence A - Accessibility', 'ACCESSIBILITY'),
    ('Sequence A - Architectural', 'ARCHITECTURAL'),
    ('Sequence A-B-C - Signage', 'VENDOR'),
    ('Sequence A - Civil', 'CIVIL'),
    ('Sequence A - Electrical', 'ELECTRICAL'),
    ('Sequence A - Fire Protection', 'FIRE_PROTECTION'),
    ('Sequence A - General Requirements', 'GENERAL_REQUIREMENTS'),
    ('Sequence A - Interiors', 'INTERIORS'),
    ('Sequence A - Landscape', 'LANDSCAPE'),
    ('Sequence A - Life Safety', 'LIFE_SAFETY'),
    ('Sequence A - Mechanical', 'MECHANICAL'),
    ('Sequence A - Plumbing', 'PLUMBING'),
    ('Sequence A - Signage', 'VENDOR'),
    ('Sequence A - Structural', 'STRUCTURAL'),
    ('Sequence A - Technology', 'COMMUNICATIONS'),
    ('Sequence B - Accessibility', 'ACCESSIBILITY'),
    ('Sequence B - Architectural', 'ARCHITECTURAL'),
    ('Sequence B - Electrical', 'ELECTRICAL'),
    ('Sequence B - Fire Protection', 'FIRE_PROTECTION'),
    ('Sequence B - General Requirements', 'GENERAL_REQUIREMENTS'),
    ('Sequence B - Interiors', 'INTERIORS'),
    ('Sequence B - Life Safety', 'LIFE_SAFETY'),
    ('Sequence B - Mechanical', 'MECHANICAL'),
    ('Sequence B - Plumbing', 'PLUMBING'),
    ('Sequence B - Technology', 'COMMUNICATIONS'),
    ('Sewer', 'PLUMBING'),
    ('Sewer Works', 'PLUMBING'),
    ('Shop', 'VENDOR'),
    ('Shop Drawing', 'VENDOR'),
    ('Shop Drawings', 'VENDOR'),
    ('Shops', 'VENDOR'),
    ('Signage', 'VENDOR'),
    ('Site', 'CIVIL'),
    ('Site Development', 'CIVIL'),
    ('Site Improvements', 'CIVIL'),
    ('Site Improvements - Prayer Garden', 'CIVIL'),
    ('Site Signage', 'VENDOR'),
    ('Site Survey', 'CIVIL'),
    ('Site Work', 'CIVIL'),
    ('Sketch', 'VENDOR'),
    ('Slab Edge', 'VENDOR'),
    ('Sound Masking', 'VENDOR'),
    ('Spalsh pad', 'VENDOR'),
    ('Special Systems', 'VENDOR'),
    ('Specifications', 'ARCHITECTURAL'), -- SPECIFICATIONS
    ('Specs', 'ARCHITECTURAL'), -- SPECIFICATIONS
    ('Sports Layouts', 'VENDOR'),
    ('Sprinkler', 'FIRE_PROTECTION'),
    ('Sprinklers', 'FIRE_PROTECTION'),
    ('SprinklerSystem', 'FIRE_PROTECTION'),
    ('Stadium', 'VENDOR'),
    ('Stairs', 'VENDOR'),
    ('Statement of Conditions', 'VENDOR'),
    ('Stealth Technologies', 'VENDOR'),
    ('Steel', 'VENDOR'),
    ('Steel Shops', 'VENDOR'),
    ('Storage', 'VENDOR'),
    ('Storage Systems', 'VENDOR'),
    ('Stress Wire', 'VENDOR'),
    ('Structural', 'STRUCTURAL'),
    ('StructuralStructural', 'STRUCTURAL'),
    ('Submittal', 'VENDOR'),
    ('Support', 'VENDOR'),
    ('SUPPORT PLAN', 'VENDOR'),
    ('Surveillance', 'COMMUNICATIONS'),
    ('Survey', 'CIVIL'),
    ('T-24', 'VENDOR'),
    ('Technology', 'COMMUNICATIONS'),
    ('Telecom', 'COMMUNICATIONS'),
    ('Telecommunication', 'COMMUNICATIONS'),
    ('Telecommunications', 'COMMUNICATIONS'),
    ('Theater', 'VENDOR'),
    ('Theater Planning', 'VENDOR'),
    ('Theatre Planning', 'VENDOR'),
    ('Title', 'GENERAL_REQUIREMENTS'),
    ('Traffic Signal', 'CIVIL'),
    ('Transportation', 'CIVIL'),
    ('umbing', 'PLUMBING'),
    ('UP & ID', 'PLUMBING'),
    ('UP&ID', 'PLUMBING'),
    ('urity & Fire Alarm', 'COMMUNICATIONS'),
    ('Utilities', 'CIVIL'),
    ('UTILITIES', 'CIVIL'),
    ('Utility', 'CIVIL'),
    ('Utility Plan', 'CIVIL'),
    ('Various', 'VENDOR'),
    ('Vendor', 'VENDOR'),
    ('Vendor | Electrical', 'VENDOR'),
    ('Vendor | Mechanical', 'VENDOR'),
    ('Vendor | Plumbing', 'VENDOR'),
    ('Vendor | Structural', 'VENDOR'),
    ('Vertical Transport', 'VENDOR'),
    ('Volume 10 - Sequence', 'ARCHITECTURAL'),
    ('Volume 10 - Sequence C', 'ARCHITECTURAL'),
    ('Volume 1 - G, LS, C, L, S', 'ARCHITECTURAL'),
    ('Volume 1 - Sequence', 'ARCHITECTURAL'),
    ('Volume 1 - Sequence A', 'ARCHITECTURAL'),
    ('Volume 2 - Architectural', 'ARCHITECTURAL'),
    ('Volume 2 - Sequence A', 'ARCHITECTURAL'),
    ('Volume 3 - Interiors', 'INTERIORS'),
    ('Volume 3 - Sequence B', 'ARCHITECTURAL'),
    ('Volume 4 - Mechanical', 'MECHANICAL'),
    ('Volume 4 - Sequence B', 'ARCHITECTURAL'),
    ('Volume 5 - Plumbing', 'PLUMBING'),
    ('Volume 5 - Sequence', 'ARCHITECTURAL'),
    ('Volume 5 - Sequence C', 'ARCHITECTURAL'),
    ('Volume 6 - Electrical', 'ELECTRICAL'),
    ('Volume 6 - Sequence', 'ARCHITECTURAL'),
    ('Volume 6 - Sequence C', 'ARCHITECTURAL'),
    ('Volume 7 - Sequence', 'ARCHITECTURAL'),
    ('Volume 7 - Sequence C', 'ARCHITECTURAL'),
    ('Volume 7 - Telecommunications', 'COMMUNICATIONS'),
    ('Volume 8 - Sequence C', 'ARCHITECTURAL'),
    ('Volume 9 - Sequence', 'ARCHITECTURAL'),
    ('Volume 9 - Sequence C', 'ARCHITECTURAL'),
    ('Wall Protection', 'ARCHITECTURAL'),
    ('Waste', 'PLUMBING'),
    ('Waste Water', 'PLUMBING'),
    ('Water', 'PLUMBING'),
    ('Water and Sewer', 'PLUMBING'),
    ('Water facility', 'PLUMBING'),
    ('Water Feature', 'PLUMBING'),
    ('Water Flow', 'PLUMBING'),
    ('Water Line', 'PLUMBING'),
    ('WaterLine', 'PLUMBING'),
    ('Water Plant', 'PLUMBING'),
    ('Water Production Bldg', 'PLUMBING'),
    ('Water Services', 'PLUMBING'),
    ('WWTP', 'PLUMBING')
;

CREATE TABLE transform.document_attributes (
    legacy_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , "value" JSONB
);

CREATE INDEX ON transform.document_attributes (legacy_id);
CREATE INDEX ON transform.document_attributes (legacy_source);

CREATE TABLE transform.documents_legacy (
    id SERIAL PRIMARY KEY
    , legacy_ids TEXT[]
    , legacy_documentable_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , item_number VARCHAR
    , status VARCHAR
    , document_type VARCHAR(20)
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , subproject VARCHAR
);

CREATE INDEX ON transform.documents_legacy USING GIN (legacy_ids);
CREATE INDEX ON transform.documents_legacy (legacy_documentable_id);
CREATE INDEX ON transform.documents_legacy (legacy_source);
CREATE INDEX ON transform.documents_legacy (item_number);
CREATE INDEX ON transform.documents_legacy (document_type);
CREATE INDEX ON transform.documents_legacy (subproject);

CREATE TABLE transform.document_revisions_legacy (
    legacy_id VARCHAR(36)
    , legacy_folder_id VARCHAR(36)
    , legacy_source VARCHAR(100)
    , legacy_path VARCHAR
    , legacy_filename VARCHAR
    , "name" VARCHAR
    , status VARCHAR
    , description VARCHAR
    , document_attributes JSONB
    , created_at TIMESTAMP
    , updated_at TIMESTAMP
    , revision VARCHAR
    , discipline VARCHAR
    , is_old BOOLEAN
);

CREATE TABLE transform.documents_production AS
    SELECT
        documents.id
        , documents.item_number
        , documents.status
        , documents.document_type
        , documents.created_at
        , documents.updated_at
        , documents.documentable_type
        , documents.documentable_id
        , documents.subproject
        , CASE
            WHEN documents.legacy_ids = '{}'
            THEN ARRAY_AGG(revisions.legacy_id ORDER BY revisions.legacy_id)::TEXT[]
            ELSE documents.legacy_ids
        END AS legacy_ids
        , COALESCE(documents.legacy_source, MAX(revisions.legacy_source)) AS legacy_source
    FROM
        public.documents
        JOIN public.document_revisions revisions
            ON documents.id = revisions.document_id
    GROUP BY
        documents.id
;

CREATE INDEX ON transform.documents_production USING GIN (legacy_ids);

CREATE TABLE transform.documents_production_added AS
    SELECT
        item_number
        , status
        , document_type
        , created_at
        , updated_at
        , documentable_type
        , documentable_id
        , subproject
        , legacy_ids
        , legacy_source
    FROM
        public.documents
    WHERE
        FALSE
;

CREATE TABLE transform.documents_production_updated AS
    SELECT
        id
        , item_number
        , status
        , document_type
        , updated_at
        , documentable_type
        , documentable_id
        , subproject
        , legacy_ids
        , legacy_source
    FROM
        public.documents
    WHERE
        FALSE
;

CREATE TABLE transform.document_revisions_production AS
    SELECT
        id
        , document_id
        , "name"
        , status
        , description
        , document_attributes
        , created_at
        , updated_at
        , revision
        , discipline
        , image_identificator
        , is_old
        , folder_id
        , legacy_id
        , legacy_source
        , legacy_path
        , legacy_filename
    FROM
        public.document_revisions
;

CREATE TABLE transform.document_revisions_production_added AS
    SELECT
        document_id
        , "name"
        , status
        , description
        , document_attributes
        , created_at
        , updated_at
        , revision
        , discipline
        , is_old
        , folder_id
        , legacy_id
        , legacy_source
        , legacy_path
        , legacy_filename
    FROM
        public.document_revisions
    WHERE
        FALSE
;

CREATE TABLE transform.document_revisions_production_updated AS
    SELECT
        id
        , document_id
        , "name"
        , status
        , description
        , document_attributes
        , created_at
        , updated_at
        , revision
        , discipline
        , image_identificator
        , is_old
        , folder_id
        , legacy_path
        , legacy_filename
    FROM
        public.document_revisions
    WHERE
        FALSE
;
