
create schema "test_app";

CREATE TABLE "test_app"."startup" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "data" jsonb NOT NULL, PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "test_app"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_test_app_startup_updated_at"
BEFORE UPDATE ON "test_app"."startup"
FOR EACH ROW
EXECUTE PROCEDURE "test_app"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_test_app_startup_updated_at" ON "test_app"."startup" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "test_app"."entrepreneur" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "startup_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("startup_id") REFERENCES "test_app"."startup"("id") ON UPDATE cascade ON DELETE cascade);
CREATE OR REPLACE FUNCTION "test_app"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_test_app_entrepreneur_updated_at"
BEFORE UPDATE ON "test_app"."entrepreneur"
FOR EACH ROW
EXECUTE PROCEDURE "test_app"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_test_app_entrepreneur_updated_at" ON "test_app"."entrepreneur" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "test_app"."request" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "startup_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("startup_id") REFERENCES "test_app"."startup"("id") ON UPDATE cascade ON DELETE cascade);
CREATE OR REPLACE FUNCTION "test_app"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_test_app_request_updated_at"
BEFORE UPDATE ON "test_app"."request"
FOR EACH ROW
EXECUTE PROCEDURE "test_app"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_test_app_request_updated_at" ON "test_app"."request" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "test_app"."response" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "request_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("request_id") REFERENCES "test_app"."request"("id") ON UPDATE cascade ON DELETE cascade);
CREATE OR REPLACE FUNCTION "test_app"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_test_app_response_updated_at"
BEFORE UPDATE ON "test_app"."response"
FOR EACH ROW
EXECUTE PROCEDURE "test_app"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_test_app_response_updated_at" ON "test_app"."response" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE "test_app"."score" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "data" jsonb NOT NULL, "response_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("response_id") REFERENCES "test_app"."response"("id") ON UPDATE cascade ON DELETE cascade);
CREATE OR REPLACE FUNCTION "test_app"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_test_app_score_updated_at"
BEFORE UPDATE ON "test_app"."score"
FOR EACH ROW
EXECUTE PROCEDURE "test_app"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_test_app_score_updated_at" ON "test_app"."score" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

alter table "test_app"."response" add column "data" jsonb
 not null;

alter table "test_app"."score" drop column "data" cascade;

alter table "test_app"."score" add column "data" jsonb
 not null;

CREATE TABLE "test_app"."entity" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "test_app"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_test_app_entity_updated_at"
BEFORE UPDATE ON "test_app"."entity"
FOR EACH ROW
EXECUTE PROCEDURE "test_app"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_test_app_entity_updated_at" ON "test_app"."entity" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;

alter table "test_app"."request" add column "entity_id" uuid
 not null;

alter table "test_app"."request"
  add constraint "request_entity_id_fkey"
  foreign key ("entity_id")
  references "test_app"."entity"
  ("id") on update cascade on delete cascade;

CREATE TABLE "test_app"."user" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "entity_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("entity_id") REFERENCES "test_app"."entity"("id") ON UPDATE cascade ON DELETE cascade);
CREATE OR REPLACE FUNCTION "test_app"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_test_app_user_updated_at"
BEFORE UPDATE ON "test_app"."user"
FOR EACH ROW
EXECUTE PROCEDURE "test_app"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_test_app_user_updated_at" ON "test_app"."user" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE EXTENSION IF NOT EXISTS pgcrypto;
