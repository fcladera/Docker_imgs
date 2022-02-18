# Based on https://raw.githubusercontent.com/iandouglas96/jackal_master/master/jackal/Dockerfile
FROM nvidia/cudagl:11.4.2-devel-ubuntu20.04

#Run the frontend first so it doesn't throw an error later
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && export TZ="America/New_York" \
 && apt-get install -y keyboard-configuration \
 && apt-get install -y tzdata \
 && ln -fs "/usr/share/zoneinfo/$TZ" /etc/localtime \
 && dpkg-reconfigure --frontend noninteractive tzdata \
 && apt-get clean

# Tools I find useful during development
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    cmake \
    cppcheck \
    gdb \
    git \
    libbluetooth-dev \
    libcwiid-dev \
    libgoogle-glog-dev \
    libspnav-dev \
    libusb-dev \
    lsb-release \
    python3-dbg \
    python3-empy \
    python3-numpy \
    python3-pip \
    python3-venv \
    software-properties-common \
    sudo \
    wget \
    locales \
    iputils-ping \
    netcat \
    iproute2 \
    dbus-x11 \
    dialog \
    fontconfig \
    apt-utils \
 && apt-get clean

# Install a good neovim version
RUN add-apt-repository -y ppa:neovim-ppa/stable \
        && apt-get update \
        && apt-get install -y neovim

# Add a user with the same user_id as the user outside the container
# Requires a docker build argument `user_id`
ARG user_id
env USER fclad
RUN useradd -U --uid ${user_id} -m -s /bin/bash $USER \
 && echo "$USER:$USER" | chpasswd \
 && adduser $USER sudo \
 && echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers.d/$USER

# Set locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Commands below run as the developer user
USER $USER

# When running a container start in the developer's home folder
WORKDIR /home/$USER
