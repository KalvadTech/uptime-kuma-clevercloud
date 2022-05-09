#!/usr/bin/env bash
set -e
set -x
[ -z "$APP_HOME" ] && export APP_HOME=$(pwd)
[ -z "$UPTIME_KUMA_VERSION" ] && export UPTIME_KUMA_VERSION="1.15.1"
[ -z "$LITESTREAM_VERSION" ] && export LITESTREAM_VERSION="0.3.8"
[ -z "$LITESTREAM_BUCKET" ] && export LITESTREAM_BUCKET="uptime-kuma"
[ -z "$DATA_DIR" ] && export DATA_DIR="$APP_HOME/fs/"


cat <<EOF > $APP_HOME/litestream.yml
dbs:
  - path: ${DATA_DIR}kuma.db
    replicas:
      - type: s3
        bucket: $LITESTREAM_BUCKET
        path: db
        endpoint: $CELLAR_ADDON_HOST
        region: fr-par
        access-key-id: $CELLAR_ADDON_KEY_ID
        secret-access-key: $CELLAR_ADDON_KEY_SECRET
EOF
./litestream replicate -config litestream.yml
