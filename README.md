# Docker image for Keithley DMM7510 EPICS IOC

This repository contains the Dockerfile used to create the Docker image with the
EPICS IOC for the Keithley DMM7510. It also contains two other IOCs that use it
for a higher level application, more specifically the ICT and the DCCT IOCs.

## Running the IOCs

The easiest way to start the IOC is, after installing Docker, running:

    docker run --rm -it --net host lnlsdig/dmm7510-ioc

This will open a bash shell into the configured environment, and you can then
start the individual IOCs manually.
