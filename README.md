[![](https://badge.imagelayers.io/inspectit/cmr:latest.svg)](https://imagelayers.io/?images=inspectit/cmr:latest 'Get your own badge on imagelayers.io')

# Dockerfile for inspectIT APM solution
This docker file bundles the central server of the open source APM solution [www.inspectit.eu](http://www.inspectit.eu). 

## Quick Start
The easiest way of starting the CMR is to execute

```bash
$ docker run -d --name inspectIT-CMR -p 8182:8182 -p 9070:9070 inspectit/cmr
```

This starts a CMR with default configuration (meaningful for most setups). The image is created with all necessary volumes to provide persistent data storage. (see the [volumes section](#volumes) for more detail)

Now get the inspectIT client from our [download page](http://www.inspectit.eu/download-inspectit/), remember to choose the correct version (Windows, Linux or Mac, 32bit or 64bit). **The release version has to match the version of your CMR** (see section "Running a specific version of the CMR" [below](#running-a-specific-version-of-the-cmr))

## Configuration

### Adjusting the buffer size
The inspectIT CMR keeps most of its data in a memory buffer, the default size is set to 1.5 GB. You can change the size by setting the environment variable BUFFER_SIZE:

```bash
$ docker run -d --name inspectIT-CMR -p 8182:8182 -p 9070:9070 -e BUFFER_SIZE=6000 inspectit/cmr
```

This will set the buffer size to 6000 MB. **Warning:** Never set the buffer size larger than the available system memory!

### Running with additional data container
Best practice at least for the current development state of Docker is to separate the service from the data by two different containers. This approach allows to keep track of the data by the data container. 

1) Start the data container.

```bash
$ docker run -d --name inspectIT-CMR-Data -v /CMR/db -v /CMR/storages -v /CMR/config inspectit/cmr true
```

2) Start the service container and use the volumes of the data container

```bash
$ docker run -d --name inspectIT-CMR -volumes-from="inspectIT-CMR-Data" -p 8182:8182 -p 9070:9070 inspectit/cmr
```

3) Backup / Access data / etc
(work in progress)

### Running with externally mapped volumes
Some people like to run Docker images with volumes being mounted to the host system. Personally, I think this is bad practise as this hinders one of the core strength of Docker: portability, but sure this is a possible setup. Advantage is that you have the persistent data easily accessible from your host.
To run the image in this fashion, run

```bash
$ docker run -d --name inspectIT-CMR -p 8182:8182 -p 9070:9070 -v [local-folder]:/CMR/db -v [local-folder]:/CMR/storage inspectit/cmr
```

### Running a specific version of the CMR
The image inspectit/cmr:latest always refers to the latest beta version of inspectIT. If you want the latest stable build, please use the image inspectit/cmr:stable. You can also use a numeric version, please see the available tags.

**Important:** The inspectIT agent version has to match _exactly_ the version of inspectIT CMR! A version check will be implemented in release 1.7

### Volumes
Several volumes are created to manage the storage.
- Metric database: All metric data is currently stored in a database on the CMR. The folder *db* is the root folder for data storage.
- Storages: inspectIT allows to persist invocation sequences in so-called storages. All storages are kept on the server in the folder *storage*
- Server Configuration: Configuration entries are stored below the folder *config*
- Agent configurations: (not integrated yet) The central server stores the instrumentation and configuration for the agents. The folder *ci* is used as root folder.

## Checking log output
Easiest way to check the log output is to use

```bash
$ docker logs inspectIT-CMR
```

If you want deeper control, connect to the running container with a shell (note: this only works with docker 1.3 and higher)

```bash
$ docker exec -it inspectIT-CMR /bin/sh
```

## InspectIT agent
The CMR collects performance data from the inspectIT agent. There are already some preconfigured docker images available:
- [Jetty](https://hub.docker.com/r/inspectit/jetty/)
- [GlassFish](https://hub.docker.com/r/inspectit/glassfish/)
- [JBoss](https://hub.docker.com/r/inspectit/jboss/)
- [Tomcat](https://hub.docker.com/r/inspectit/tomcat/)

If you have another server, for example Weblogic, please refer to our [documentation](https://documentation.novatec-gmbh.de/display/INSPECTIT/Installation+Weblogic) or write a comment.

## Build the docker image
If you want to build the inspectIT CMR image yourself, checkout our repository and run 

```bash
$ docker build -t inspectit/cmr .
```

You need a docker installation or the - fantastic - boot2docker if you are on Windows or Mac

## Issues
If you have problems with this image or any questions feel free to create an [issue](https://github.com/inspectit-docker/cmr/issues/new) or leave a comment below.

## Contributions
If you wan't to contribute to this image, please look at the sources at [github](https://github.com/inspectit-docker/cmr) and send us a pull request.
