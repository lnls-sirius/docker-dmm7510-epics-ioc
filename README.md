# Docker image for Keithley DMM7510 EPICS IOC

This repository contains the Dockerfile used to create the Docker image with the
[EPICS IOC for the Keithley DMM7510](https://github.com/lnls-dig/dmm7510-epics-ioc).
It also contains two other IOCs that use it for a higher level application, more
specifically the ICT and the DCCT IOCs.

## Running the IOCs

The easiest way to start the IOC is, after installing Docker, running:

    docker run --rm -it --net host lnlsdig/dmm7510-epics-ioc bash

This will open a bash shell into the configured environment, and you can then
start the individual IOCs manually.

There are a few environment variables that are needed for the IOC to run properly:

    DMM7510_INSTANCE
    DMM7510_<DM7510_INSTANCE>_DEVICE_IP
    DMM7510_<DM7510_INSTANCE>_PV_AREA_PREFIX
    DMM7510_<DM7510_INSTANCE>_PV_DEVICE_PREFIX

A working example on how to run this image is by running:

    docker run --name docker-dmm7510-test -it --rm -e DMM7510_INSTANCE=DCCT1 \
        -e DMM7510_DCCT1_DEVICE_IP=10.2.117.32 -e DMM7510_DCCT1_PV_AREA_PREFIX=AS-Inj \
        -e DMM7510_DCCT1_PV_DEVICE_PREFIX=DI:DCCT lnls/dmm7510-epics-ioc
