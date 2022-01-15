#!/bin/bash

FIRST_MIGRATION="$(git status --short migrations/ | head -n1 | awk '{print $2}')"
DATABASE_NAME="$(echo "${FIRST_MIGRATION}" | awk -F "/" '{print $2}')"
FIRST_MIGRATION_VERSION="$(echo "${FIRST_MIGRATION}" | awk -F "/" '{print $3}' | awk -F "_" '{print $1}')"

hasura migrate squash --name "${1}" --from "${FIRST_MIGRATION_VERSION}" --database-name "${DATABASE_NAME}"