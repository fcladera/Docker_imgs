Docker image builds and execution
=================================

Stack of personal Docker images.

These script are based on Ian's work, which is based on the OSRF work. Provides a way to generate images that have the right privileges and mount the right volumes.

To join the containers, use dockexec
```
function dockexec() {
  docker exec --privileged -e DISPLAY=${DISPLAY} -e LINES=`tput lines` -it $1 bash
}
```
