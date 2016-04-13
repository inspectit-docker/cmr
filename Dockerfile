FROM alpine:3.3

MAINTAINER info.inspectit@novatec-gmbh.de

ENV INSPECTIT_VERSION 1.6.7.79

COPY dumb-init /dumb-init

RUN apk --no-cache add ca-certificates wget \
 && wget https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.22-r5/glibc-2.22-r5.apk \
 && apk --allow-untrusted add glibc-2.22-r5.apk \
 && wget --no-check-certificate -O /inspectit-cmr.linux.x64.tar.gz https://github.com/inspectIT/inspectIT/releases/download/${INSPECTIT_VERSION}/inspectit-cmr.linux.x64.tar.gz \
 && gunzip /inspectit-cmr.linux.x64.tar.gz \
 && tar xf /inspectit-cmr.linux.x64.tar \
 && rm *.apk \
 && rm /inspectit-cmr.linux.x64.tar

WORKDIR /CMR

VOLUME ["config", "db", "storage", "ci"]

EXPOSE 8182 9070

COPY run.sh run.sh
CMD /bin/sh run.sh
