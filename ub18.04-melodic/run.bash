#!/usr/bin/env bash

# based on https://github.com/iandouglas96/jackal_master/blob/master/run.bash

# Set the image name to the current dir
curr_dir=${PWD##*/}
IMG="fclad/$curr_dir"

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

#docker run \
docker run --gpus all \
  -u 1000 \
  -it \
  --workdir /home/fclad \
  --privileged \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/dev:/dev" \
  -v "/media/$USER:/media/fclad" \
  --network host \
  -h "$curr_dir" \
  --add-host "$curr_dir:127.0.0.1" \
  --volume="/home/fclad/.vim:/home/fclad/.vim:ro" \
  --volume="/home/fclad/.vimrc:/home/fclad/.vimrc:ro" \
  --volume="/home/fclad/.config/nvim:/home/fclad/.config/nvim:ro" \
  --volume="/home/fclad/.bash_history:/home/fclad/.bash_history" \
  --volume="/home/fclad/.config/catkin:/home/fclad/.config/catkin" \
  --volume="/nvault/GRASP/ROS_ws:/ROS_ws" \
  --volume="/nvault/GRASP/bags:/bags" \
  --rm \
  --security-opt seccomp=unconfined \
  --group-add=dialout \
  $IMG
