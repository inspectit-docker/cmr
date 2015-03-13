FROM progrium/busybox

MAINTAINER info.inspectit@novatec-gmbh.de

ENV INSPECTIT_VERSION 1.6.2.65

RUN wget ftp://ftp.novatec-gmbh.de/inspectit/releases/RELEASE.${INSPECTIT_VERSION}/inspectit-cmr.linux.x64.tar.gz -qO - | gunzip | tar xvf - 
WORKDIR /CMR
ENV PATH /CMR:$PATH
EXPOSE 8182 9070

CMD /bin/sh startup.sh
