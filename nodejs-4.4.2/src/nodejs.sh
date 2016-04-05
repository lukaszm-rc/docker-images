#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
set -- node "$@"
fi

if [ "$1" = 'node' ]; then
chown -R nobody /app

exec gosu nobody "$@"
fi

exec "$@"
