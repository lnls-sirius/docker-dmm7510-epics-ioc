FROM lnls/epics-dist:centos-7.4.1708

RUN git clone https://github.com/lnls-dig/dmm7510-epics-ioc.git /opt/epics/dmm7510-epics-ioc && \
    cd /opt/epics/dmm7510-epics-ioc && \
    git checkout 93939685dd92011a74f5cfb6e3fd5d3674a3fbad && \
    sed -i -e 's|^EPICS_BASE=.*$|EPICS_BASE=/opt/epics/base|' configure/RELEASE && \
    sed -i -e 's|^SUPPORT=.*$|SUPPORT=/opt/epics/synApps_5_8/support|' configure/RELEASE && \
    sed -i -e 's|^STREAM=.*$|STREAM=/opt/epics/stream|' configure/RELEASE && \
    make && \
    make install && \
    make clean

# Source environment variables until we figure it out
# where to put system-wide env-vars on docker-debian
RUN . /root/.bashrc
