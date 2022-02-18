#!/usr/bin/env bash

# based on https://github.com/iandouglas96/jackal_master/blob/master/run.bash

# Check that we have at least one param
if [ $# -ne 1 ]
  then
    echo "Syntax: $0 docker_img"
    exit 1
fi

# Set the image name to the argument of the script
IMG="fclad/$1"

# Check if the docker img exists locally
if [[ "$(docker images -q $IMG 2> /dev/null)" == "" ]]; then
    echo "Image $IMG does not exist locally. Is the name correct?"
    exit 1
fi

# Set hostname by removing all dots from the first argument
HOSTNAME=${1//./-}
echo "Starting $IMG in hostname $HOSTNAME"

# Make sure processes in the container can connect to the x server
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

docker run --gpus all \
  -u 1000 \
  -it \
  --workdir /home/fclad \
  --privileged \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  --network host \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/dev:/dev" \
  -v "/media/$USER:/media/fclad" \
  -h "$HOSTNAME" \
  --add-host "$HOSTNAME:127.0.0.1" \
  --volume="/home/fclad/.config/nvim:/home/fclad/.config/nvim:ro" \
  --volume="/home/fclad/.bash_history:/home/fclad/.bash_history" \
  --volume="/home/fclad/.ssh:/home/fclad/.ssh" \
  --volume="/nvault/GRASP/ROS_ws:/ROS_ws" \
  --volume="/nvault/GRASP/bags:/bags" \
  --rm \
  --security-opt seccomp=unconfined \
  --group-add=dialout \
  $IMG
