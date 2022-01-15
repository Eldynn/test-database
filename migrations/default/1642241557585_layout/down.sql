
DROP TABLE "test_app"."user";

alter table "test_app"."request" drop constraint "request_entity_id_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "test_app"."request" add column "entity_id" uuid
--  not null;

DROP TABLE "test_app"."entity";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "test_app"."score" add column "data" jsonb
--  not null;

alter table "test_app"."score" alter column "data" drop not null;
alter table "test_app"."score" add column "data" jsonb;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "test_app"."response" add column "data" jsonb
--  not null;

DROP TABLE "test_app"."score";

DROP TABLE "test_app"."response";

DROP TABLE "test_app"."request";

DROP TABLE "test_app"."entrepreneur";

DROP TABLE "test_app"."startup";

drop schema "test_app" cascade;
