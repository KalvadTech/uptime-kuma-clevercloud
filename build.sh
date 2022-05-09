#!/usr/bin/env bash
set -e
set -x
[ -z "$APP_HOME" ] && export APP_HOME=$(pwd)
[ -z "$UPTIME_KUMA_VERSION" ] && export UPTIME_KUMA_VERSION="1.15.1"
[ -z "$LITESTREAM_VERSION" ] && export LITESTREAM_VERSION="0.3.8"
[ -z "$LITESTREAM_BUCKET" ] && export LITESTREAM_BUCKET="uptime-kuma"

rm -rf $APP_HOME/uptime-kuma*
wget -O uptime-kuma-$UPTIME_KUMA_VERSION.tar.gz https://github.com/louislam/uptime-kuma/archive/refs/tags/$UPTIME_KUMA_VERSION.tar.gz
tar xvzf uptime-kuma-$UPTIME_KUMA_VERSION.tar.gz

rm -rf $APP_HOME/litestream*
wget https://github.com/benbjohnson/litestream/releases/download/v$LITESTREAM_VERSION/litestream-v$LITESTREAM_VERSION-linux-amd64-static.tar.gz
tar xvzf litestream-v$LITESTREAM_VERSION-linux-amd64-static.tar.gz
cd uptime-kuma-$UPTIME_KUMA_VERSION
npm ci --production && npm run download-dist

mkdir -p $APP_HOME/fs
