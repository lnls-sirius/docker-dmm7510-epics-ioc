#!/usr/bin/env bash

set -u

if [ -z "$DMM7510_INSTANCE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 1
fi

/usr/bin/docker stop \
    dmm7510-epics-ioc-${DMM7510_INSTANCE}
