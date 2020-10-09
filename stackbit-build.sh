#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5f7fedc6e67ba7001cbf25ef/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5f7fedc6e67ba7001cbf25ef 
fi
curl -s -X POST https://api.stackbit.com/project/5f7fedc6e67ba7001cbf25ef/webhook/build/ssgbuild > /dev/null
./ssg-build.sh
curl -s -X POST https://api.stackbit.com/project/5f7fedc6e67ba7001cbf25ef/webhook/build/publish > /dev/null
