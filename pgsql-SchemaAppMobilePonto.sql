-- DROP SCHEMA "SchemaAppMobile";

CREATE SCHEMA "SchemaAppMobile" AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA "SchemaAppMobile" IS 'standard public schema';
-- "SchemaAppMobile".auth_group definição

-- Drop table

-- DROP TABLE "SchemaAppMobile".auth_group;

CREATE TABLE "SchemaAppMobile".auth_group (
	id uuid NOT NULL,
	"name" varchar(255) NOT NULL,
	CONSTRAINT auth_group_name_unique UNIQUE (name),
	CONSTRAINT auth_group_pkey PRIMARY KEY (id)
);
CREATE INDEX auth_group_id_index ON "SchemaAppMobile".auth_group USING btree (id);

-- Permissions

ALTER TABLE "SchemaAppMobile".auth_group OWNER TO admindbpostgres;
GRANT ALL ON TABLE "SchemaAppMobile".auth_group TO admindbpostgres;


-- "SchemaAppMobile".auth_user definição

-- Drop table

-- DROP TABLE "SchemaAppMobile".auth_user;

CREATE TABLE "SchemaAppMobile".auth_user (
	id uuid NOT NULL,
	"password" varchar(255) NOT NULL,
	last_login timestamp(0) NULL,
	is_superuser bool DEFAULT false NOT NULL,
	username varchar(255) NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	is_staff bool NOT NULL,
	is_active bool DEFAULT true NOT NULL,
	created_at timestamp(0) NOT NULL,
	CONSTRAINT auth_user_email_unique UNIQUE (email),
	CONSTRAINT auth_user_pkey PRIMARY KEY (id),
	CONSTRAINT auth_user_username_unique UNIQUE (username)
);
CREATE INDEX auth_user_id_email_username_index ON "SchemaAppMobile".auth_user USING btree (id, email, username);

-- Permissions

ALTER TABLE "SchemaAppMobile".auth_user OWNER TO admindbpostgres;
GRANT ALL ON TABLE "SchemaAppMobile".auth_user TO admindbpostgres;


-- "SchemaAppMobile".content_type definição

-- Drop table

-- DROP TABLE "SchemaAppMobile".content_type;

CREATE TABLE "SchemaAppMobile".content_type (
	id uuid NOT NULL,
	app_label varchar(255) NOT NULL,
	model varchar(255) NOT NULL,
	CONSTRAINT content_type_pkey PRIMARY KEY (id)
);
CREATE INDEX content_type_app_label_model_index ON "SchemaAppMobile".content_type USING btree (app_label, model);

-- Permissions

ALTER TABLE "SchemaAppMobile".content_type OWNER TO admindbpostgres;
GRANT ALL ON TABLE "SchemaAppMobile".content_type TO admindbpostgres;


-- "SchemaAppMobile".authority_permission definição

-- Drop table

-- DROP TABLE "SchemaAppMobile".authority_permission;

CREATE TABLE "SchemaAppMobile".authority_permission (
	id uuid NOT NULL,
	codename varchar(255) NOT NULL,
	object_id uuid NOT NULL,
	approved bool DEFAULT false NOT NULL,
	date_requested timestamp(0) NOT NULL,
	date_approved timestamp(0) NULL,
	content_type_id uuid NOT NULL,
	creator_id uuid NULL,
	group_id uuid NOT NULL,
	user_id uuid NOT NULL,
	CONSTRAINT authority_permission_pkey PRIMARY KEY (id),
	CONSTRAINT authority_permission_user_id_content_type_id_group_id_object_id UNIQUE (user_id, content_type_id, group_id, object_id, codename),
	CONSTRAINT authority_permission_content_type_id_foreign FOREIGN KEY (content_type_id) REFERENCES "SchemaAppMobile".content_type(id),
	CONSTRAINT authority_permission_creator_id_foreign FOREIGN KEY (creator_id) REFERENCES "SchemaAppMobile".auth_user(id),
	CONSTRAINT authority_permission_group_id_foreign FOREIGN KEY (group_id) REFERENCES "SchemaAppMobile".auth_group(id),
	CONSTRAINT authority_permission_user_id_foreign FOREIGN KEY (user_id) REFERENCES "SchemaAppMobile".auth_user(id)
);

-- Permissions

ALTER TABLE "SchemaAppMobile".authority_permission OWNER TO admindbpostgres;
GRANT ALL ON TABLE "SchemaAppMobile".authority_permission TO admindbpostgres;

-- "SchemaAppMobile".records_history_user definição

-- Drop table

-- DROP TABLE "SchemaAppMobile".records_history_user;

CREATE TABLE "SchemaAppMobile".records_history_user (
	id uuid NOT NULL,
	created_at timestamp(0) NOT NULL,
	record_date timestamp(0) NOT NULL,
	record_type varchar(255) NOT NULL,
	user_id uuid NOT NULL,
	latitude numeric(9, 6) NOT NULL,
	longitude numeric(9, 6) NOT NULL,
	CONSTRAINT records_history_user_pkey PRIMARY KEY (id),
	CONSTRAINT records_history_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES "SchemaAppMobile".auth_user(id)
);
CREATE INDEX records_history_user_id_user_id_index ON "SchemaAppMobile".records_history_user USING btree (id, user_id);

-- Permissions

ALTER TABLE "SchemaAppMobile".records_history_user OWNER TO admindbpostgres;
GRANT ALL ON TABLE "SchemaAppMobile".records_history_user TO admindbpostgres;

-- Permissions

GRANT ALL ON SCHEMA "SchemaAppMobile" TO pg_database_owner;
GRANT USAGE ON SCHEMA "SchemaAppMobile" TO public;