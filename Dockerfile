FROM lnls/epics-dist:debian-9.2

RUN git clone https://github.com/lnls-dig/dmm7510-epics-ioc.git /opt/epics/dmm7510-epics-ioc && \
    cd /opt/epics/dmm7510-epics-ioc && \
    git checkout bc650f6f89730c2b3b8cdd4f84e0c39864d5c56d && \
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
