# Base image for yocto
FROM fclad/ub18.04
MAINTAINER fcladera@fcladera.com

RUN sudo apt-get update
RUN sudo apt-get upgrade -y

# Yocto setup
RUN sudo apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping libsdl1.2-dev xterm git-lfs bc

# Misc tools setup
RUN sudo apt-get -y install curl tree
RUN curl -k https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo && chmod a+x ~/.local/bin/repo
