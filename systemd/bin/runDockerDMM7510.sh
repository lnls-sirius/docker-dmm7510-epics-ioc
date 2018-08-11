#!/usr/bin/env bash

set -u

if [ -z "$DMM7510_INSTANCE" ]; then
    echo "Device type is not set. Please use -d option" >&2
    exit 1
fi

DMM7510_TYPE=$(echo ${DMM7510_INSTANCE} | grep -Eo "[^0-9]+");
DMM7510_NUMBER=$(echo ${DMM7510_INSTANCE} | grep -Eo "[0-9]+");

if [ -z "$DMM7510_TYPE" ]; then
    echo "DMM7510 device type is not set. Please check the DMM7510_INSTANCE environment variable" >&2
    exit 2
fi

if [ -z "$DMM7510_NUMBER" ]; then
    echo "DMM7510 number is not set. Please check the DMM7510_INSTANCE environment variable" >&2
    exit 3
fi

export DMM7510_CURRENT_PV_AREA_PREFIX=DMM7510_${DMM7510_INSTANCE}_PV_AREA_PREFIX
export DMM7510_CURRENT_PV_DEVICE_PREFIX=DMM7510_${DMM7510_INSTANCE}_PV_DEVICE_PREFIX
export DMM7510_CURRENT_DEVICE_IP=DMM7510_${DMM7510_INSTANCE}_DEVICE_IP
export DMM7510_CURRENT_DEVICE_PORT=DMM7510_${DMM7510_INSTANCE}_DEVICE_PORT
export DMM7510_CURRENT_TELNET_PORT=DMM7510_${DMM7510_INSTANCE}_TELNET_PORT
# Only works with bash
export DMM7510_PV_AREA_PREFIX=${!DMM7510_CURRENT_PV_AREA_PREFIX}
export DMM7510_PV_DEVICE_PREFIX=${!DMM7510_CURRENT_PV_DEVICE_PREFIX}
export DMM7510_DEVICE_IP=${!DMM7510_CURRENT_DEVICE_IP}
export DMM7510_DEVICE_PORT=${!DMM7510_CURRENT_DEVICE_PORT}
export DMM7510_TELNET_PORT=${!DMM7510_CURRENT_TELNET_PORT}

# Create volume for autosave and ignore errors
/usr/bin/docker create \
    -v /opt/epics/startup/ioc/dmm7510-epics-ioc/iocBoot/iocdmm7510/autosave \
    --name dmm7510-epics-ioc-${DMM7510_INSTANCE}-volume \
    lnlsdig/dmm7510-epics-ioc:${IMAGE_VERSION} \
    2>/dev/null || true

# Remove a possible old and stopped container with
# the same name
/usr/bin/docker rm \
    dmm7510-epics-ioc-${DMM7510_INSTANCE} || true

/usr/bin/docker run \
    --net host \
    -t \
    --rm \
    --volumes-from dmm7510-epics-ioc-${DMM7510_INSTANCE}-volume \
    --name dmm7510-epics-ioc-${DMM7510_INSTANCE} \
    lnlsdig/dmm7510-epics-ioc:${IMAGE_VERSION} \
    -t "${DMM7510_TELNET_PORT}" \
    -i "${DMM7510_DEVICE_IP}" \
    -p "${DMM7510_DEVICE_PORT}" \
    -d "${DMM7510_INSTANCE}" \
    -P "${DMM7510_PV_AREA_PREFIX}" \
    -R "${DMM7510_PV_DEVICE_PREFIX}"
