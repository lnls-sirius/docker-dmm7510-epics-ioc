FROM lnls/epics-dist:debian-9.2

RUN git clone https://github.com/lnls-dig/dmm7510-epics-ioc.git /opt/epics/dmm7510-epics-ioc && \
    cd /opt/epics/dmm7510-epics-ioc && \
    git checkout 3c827311ca84aaffd898c1cb23a38ececa021b6c && \
    sed -i -e 's|^EPICS_BASE=.*$|EPICS_BASE=/opt/epics/base|' configure/RELEASE && \
    sed -i -e 's|^SUPPORT=.*$|SUPPORT=/opt/epics/synApps_5_8/support|' configure/RELEASE && \
    sed -i -e 's|^STREAM=.*$|STREAM=/opt/epics/stream|' configure/RELEASE && \
    make && \
    make install && \
    make clean

# Source environment variables until we figure it out
# where to put system-wide env-vars on docker-debian
RUN . /root/.bashrc
