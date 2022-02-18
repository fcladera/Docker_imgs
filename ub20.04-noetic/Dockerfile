# Based on https://raw.githubusercontent.com/iandouglas96/jackal_master/master/jackal/Dockerfile
FROM fclad/ub20.04

# Install ROS noetic
RUN sudo apt-get update \
 && sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
 && sudo apt install -y curl \
 && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - \
 && sudo apt-get update \
 && sudo apt-get install -y \
    python3-catkin-tools \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstool \
    ros-noetic-desktop-full \
    ros-noetic-pointcloud-to-laserscan \
    ros-noetic-robot-localization \
    ros-noetic-spacenav-node \
    ros-noetic-tf2-sensor-msgs \
    ros-noetic-twist-mux \
    ros-noetic-velodyne-simulator \
    ros-noetic-vision-msgs \
    python3-yaml \
    python3-pycryptodome \
    python3-gnupg \
    libsuitesparse-dev \
    libv4l-dev \
    libceres-dev \
    ros-noetic-random-numbers

RUN sudo rosdep init \
 && sudo apt-get clean

RUN rosdep update

RUN pip3 install osrf-pycommon

RUN /bin/sh -c 'echo ". /opt/ros/noetic/setup.bash" >> ~/.bashrc'
