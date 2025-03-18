FROM registry.fedoraproject.org/fedora

USER root

RUN dnf install -y git make nodejs && \
    npm install -g n && \
    n lts && \
    npm install -g npm@latest && \
    dnf remove -y nodejs

ARG QUARTZ_FORK=jackyzha0
ARG QUARTZ_REF=v4

RUN cd /opt && git clone https://github.com/${QUARTZ_FORK}/quartz.git && \
    cd quartz && git checkout ${QUARTZ_REF} && \
    npm ci

COPY quartz.config.ts /opt/quartz/

WORKDIR /opt/quartz
