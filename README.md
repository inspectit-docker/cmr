# Dockerfile for inspectIT APM solution
This docker file bundles the central server of the open source APM solution (www.inspectit.eu). 

## Starting
The easiest way of starting the CMR is to execute
```
sudo docker run -d --name inspectIT-CMR -p 8182:8182 -p 9070:9070 inspectit/cmr
```
This starts a CMR with default configuration (meaningful for most setups). The image is created with all necessary volumes to provide persistent data storage. (see the volumes section for more detail)

## Build
Build the inspectIT CMR image by calling the 
```
build.sh
```
file. You need a docker installation or the - fantastic - boot2docker if you are on Windows or Mac

## Running with externally mapped volumes
Some people like to run Docker images with volumnes being mounted to the host system. Personally I think this is bad practise as this hinders one of the core strength of Docker: portability, but sure this is a possible setup. Advantage is that you have the persistent data easily accessible from your host.
To run the image in this fashion, run
```
sudo docker run -d --name inspectIT-CMR -p 8182:8182 -p 9070:9070 -v [local-folder]:/CMR/db -v [local-folder]:/CMR/storage inspectit/cmr
```

## Running with additional data container
Best practice at least for the current development state of Docker is to separate the service from the data by two different containers. This approach allows to keep track of the data by the data container. 
1) Start the data container.
```
sudo docker run -d --name inspectIT-CMR-Data -v /CMR/db -v /CMR/storages -v /CMR/config busybox /bin/sh
```
2) Start the service container and use the volumes of the data container
```
sudo docker run -d --name inspectIT-CMR -volumes-from="inspectIT-CMR-Data" -p 8182:8182 -p 9070:9070 inspectit/cmr
```
3) Backup / Access data / etc
(work in progress)

## Running a specific version of the CMR
(work in progress)

## Volumes
Several volumes are created to manage the storage.
- Metric database: All metric data is currently stored in a database on the CMR. The folder *db* is the root folder for data storage.
- Storages: inspectIT allows to persist invocation sequences in so-called storages. All storages are kept on the server in the folder *storage*
- Server Configuration: Configuration entries are stored below the folder *config*
- Agent configurations: (not integrated yet) The central server stores the instrumentation and configuration for the agents. The folder *ci* is used as root folder.

## Checking log output
Easiest way to check the log output is to use
```
sudo docker logs inspectIT-CMR
```
If you want deeper control, connect to the running container with a shell (note this only works with docker v3 and higher)
```
sudo docker exec -it inspectIT-CMR /bin/bash
```
