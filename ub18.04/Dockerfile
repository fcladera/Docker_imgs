# Based on https://raw.githubusercontent.com/iandouglas96/jackal_master/master/jackal/Dockerfile
FROM nvidia/cudagl:11.4.1-devel-ubuntu18.04

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
        python-pip \
        software-properties-common \
        sudo \
        wget \
        locales \
        iputils-ping \
        netcat \
        iproute2 \
        dbus-x11 \
        rsync \
 && apt-get clean

# Add a user with the same user_id as the user outside the container
# Requires a docker build argument `user_id`
ARG user_id
ARG user_name
env USER $user_name

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

# docker is run
RUN export DEBIAN_FRONTEND=noninteractive \
 && sudo apt-get update \
 && sudo -E apt-get install -y \
    tzdata \
 && sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
 && sudo dpkg-reconfigure --frontend noninteractive tzdata \
 && sudo apt-get clean \\

# Setup neovim
RUN sudo add-apt-repository ppa:neovim-ppa/stable \
  && sudo apt-get update \
  && sudo apt-get install -y neovim python-dev python-pip python3-dev python3-pip \
  && sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 \
  && sudo update-alternatives --config vi \
  && sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 \
  && sudo update-alternatives --config vim \
  && sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60 \
  && sudo update-alternatives --config editor

# Setup pip
RUN pip2 install --upgrade pip
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade msgpack

RUN git config --global user.name "Fernando Cladera" && git config --global user.email "fcladera@fcladera.com"

# When running a container start in the developer's home folder
ENV PATH="/home/$USER/.local/bin:$PATH"
WORKDIR /home/$USER
