# Based on https://raw.githubusercontent.com/iandouglas96/jackal_master/master/jackal/Dockerfile
FROM fclad/ub18.04

# Install ROS melodic
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \ && sudo /bin/sh -c 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' \
 && sudo apt-get update \
 && sudo apt-get install -y \
    libgazebo9-dev \
    gazebo9 \
    python-catkin-tools \
    python-rosdep \
    python-rosinstall \
    ros-melodic-desktop-full \
    ros-melodic-joystick-drivers \
    ros-melodic-pointcloud-to-laserscan \
    ros-melodic-robot-localization \
    ros-melodic-spacenav-node \
    ros-melodic-tf2-sensor-msgs \
    ros-melodic-twist-mux \
    ros-melodic-velodyne-simulator \
    python3-yaml \
    python3-pycryptodome \
    python3-gnupg \
    libsuitesparse-dev \
    ros-melodic-random-numbers \
    ros-melodic-vision-msgs \
    libv4l-dev \
    libceres-dev \
    python-igraph \
    ros-melodic-ros-numpy

RUN pip2 install scipy

RUN pip3 install rospkg
RUN pip3 install opencv-python
RUN pip3 install jupyter
RUN pip3 install jupyterlab
RUN pip3 install matplotlib
RUN pip3 install seaborn

RUN sudo rosdep init \
 && sudo apt-get clean

RUN rosdep update

RUN /bin/sh -c 'echo ". /opt/ros/melodic/setup.bash" >> ~/.bashrc'
