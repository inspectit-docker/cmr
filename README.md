# Dockerfile for inspectIT APM solution
This docker file bundles the central server of the open source APM solution (www.inspectit.eu). 

## Build
Build the inspectIT CMR image by calling the 
```
build.sh
```
file. You need a docker installation or the - fantastic - boot2docker if you are on Windows or Mac

## Volumes
Several volumes are created to manage the storage.
- Metric database: All metric data is currently stored in a database on the CMR. The folder *db* is the root folder for data storage.
- Storages: inspectIT allows to persist invocation sequences in so-called storages. All storages are kept on the server in the folder *storage*
- Server Configuration: Configuration entries are stored below the folder *config*
- Agent configurations: (not integrated yet) The central server stores the instrumentation and configuration for the agents. The folder *ci* is used as root folder.
