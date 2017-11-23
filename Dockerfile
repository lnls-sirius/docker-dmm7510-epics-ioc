FROM lnls/epics-dist:centos-7.4.1708

RUN git clone https://github.com/lnls-dig/dmm7510-epics-ioc.git /opt/epics/dmm7510-epics-ioc && \
    cd /opt/epics/dmm7510-epics-ioc && \
    git checkout 06402f40ab5ee3c35c8417b995f5dfff5d5809c9 && \
    sed -i -e 's|^EPICS_BASE=.*$|EPICS_BASE=/opt/epics/base|' configure/RELEASE && \
    sed -i -e 's|^SUPPORT=.*$|SUPPORT=/opt/epics/synApps_5_8/support|' configure/RELEASE && \
    sed -i -e 's|^STREAM=.*$|STREAM=/opt/epics/stream|' configure/RELEASE && \
    make && \
    make install && \
    make clean

# Source environment variables until we figure it out
# where to put system-wide env-vars on docker-debian
RUN . /root/.bashrc

ENV EPICS_WORKDIR /opt/epics/startup/ioc/dmm7510-epics-ioc/iocBoot/iocdmm7510

WORKDIR $EPICS_WORKDIR

ENTRYPOINT ["/opt/epics/startup/ioc/dmm7510-epics-ioc/iocBoot/iocdmm7510/runProcServ.sh"]
