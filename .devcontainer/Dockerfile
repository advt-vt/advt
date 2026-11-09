# specifically request for ubuntu-24.04. default base:ubuntu requests for latest 26.04
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

USER root

ARG USERNAME=advt_user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Stores what architecture we are on (x84 or arm64)
ARG TARGETARCH

ENV SHELL=/bin/bash

# Rename vscode user (comes with the ubuntu image) to advt_user
RUN groupmod -n $USERNAME vscode \
    && usermod -l $USERNAME -d /home/$USERNAME -m vscode

# make sure we own and can edit all the files
RUN groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME

# install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    astyle \
    automake \
    binutils-dev \
    bison \
    build-essential \
    ca-certificates \
    ccache \
    clang \
    clang-format \
    clang-tidy \
    cmake \
    cppcheck \
    curl \
    esptool \
    file \
    flex \
    g++ \
    g++-multilib \
    gcc \
    gcc-arm-none-eabi \
    gcc-multilib \
    gdb \
    gdb-multiarch \
    genromfs \
    gettext \
    git \
    gnupg \
    gosu \
    gperf \
    kconfig-frontends \
    lcov \
    libelf-dev \
    libexpat-dev \
    libgl1-mesa-dri \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    libncurses-dev \
    libncurses6 \
    libncursesw6 \
    libnewlib-arm-none-eabi \
    libopencv-dev \
    libssl-dev \
    libstdc++-arm-none-eabi-newlib \
    libtool \
    libunwind-dev \
    libxcb-cursor0 \
    libxml2-dev \
    libxml2-utils \
    lld \
    lldb \
    lsb-release \
    make \
    mesa-utils \
    ninja-build \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-venv \
    python3-wheel \
    rsync \
    screen \
    shellcheck \
    software-properties-common \
    sudo \
    texinfo \
    u-boot-tools \
    unzip \
    util-linux \
    vim-common \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Add user to sudoers group
RUN echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Fetch Xtensa compilers for Nuttx
ARG XTENSA_FILE_NAME=xtensa-esp-elf-13.2.0_20240530-x86_64-linux-gnu.tar.xz
RUN wget -q -P /tmp https://github.com/espressif/crosstool-NG/releases/download/esp-13.2.0_20240530/$XTENSA_FILE_NAME \
    && tar -xf /tmp/$XTENSA_FILE_NAME -C /opt \
    && rm /tmp/$XTENSA_FILE_NAME \
    && echo 'export PATH=$PATH:/opt/xtensa-esp-elf/bin/' >> /home/$USERNAME/.bashrc \
    && usermod -aG dialout $USERNAME

# install Nuttx packages for Arm64
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        apt-get install -y --no-install-recommends \
        g++-aarch64-linux-gnu \
        g++-arm-linux-gnueabihf \
        && rm -rf /var/lib/apt/lists/* \
    fi

# gazebo binary install
RUN curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null \
    && apt-get update \
    && apt-get install -y gz-jetty \
    && rm -rf /var/lib/apt/lists/*

USER $USERNAME

# Setup python virtual environment for Ubuntu PEP 668
# The ubuntu image needs pip to be in a venv
RUN python3 -m venv /home/$USERNAME/.venv
ENV PATH="/home/$USERNAME/.venv/bin:$PATH"


# Install python packages (as user)
COPY pip_requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt
