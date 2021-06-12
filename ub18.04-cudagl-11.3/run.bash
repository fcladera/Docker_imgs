#!/usr/bin/env bash

# based on https://github.com/iandouglas96/jackal_master/blob/master/run.bash

IMG="ub18.04-cudagl-11.3"

# Make sure processes in the container can connect to the x server
# Necessary so gazebo can create a context for OpenGL rendering (even headless)
XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

echo "RUNNING DOCKER IMAGE: " $1

docker run --gpus all \
  -u 1000 \
  -it \
  --workdir /home/dcist \
  --privileged \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/dev:/dev" \
  -v "/media/$USER:/media/dcist" \
  --network host \
  -h jackal \
  --add-host jackal:127.0.0.1 \
  --add-host jackal:192.168.8.100 \
  --volume="/home/fclad/.vim:/root/.vim:ro" \
  --volume="/home/fclad/.vimrc:/root/.vimrc:ro" \
  --volume="/home/fclad/.config/nvim:/root/.config/nvim:ro" \
  --volume="/samsungSSD:/samsungSSD" \
  --rm \
  --security-opt seccomp=unconfined \
  --group-add=dialout \
  $IMG
