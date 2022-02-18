# Based on https://raw.githubusercontent.com/iandouglas96/jackal_master/master/jackal/Dockerfile
FROM fclad/ub20.04

# Install ROS2 galactic
RUN sudo apt-get update \
 && sudo apt-get install -y curl gnupg2 lsb-release \
 && sudo apt-get install -y software-properties-common \
 && sudo add-apt-repository universe \
 && sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null \
 && sudo apt-get update \
 && sudo apt-get install -y ros-galactic-desktop \
    python3-yaml \
    python3-pycryptodome \
    python3-gnupg \
    libsuitesparse-dev \
    libv4l-dev \
    libceres-dev \
    python3-colcon-common-extensions \
    ros-galactic-rmw-cyclonedds-cpp

RUN sudo apt-get clean

RUN /bin/sh -c 'echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc'
