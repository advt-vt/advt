FROM mcr.microsoft.com/devcontainers/base:ubuntu

USER root

ARG USERNAME=advt_user
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV SHELL=/bin/bash

# Rename vscode user (comes with the ubuntu image) to advt_user
RUN groupmod -n $USERNAME vscode \
    && usermod -l $USERNAME -d /home/$USERNAME -m vscode

RUN groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME \
    && apt-get update \
    && apt-get install -y \
    sudo \
    curl \
    git \
    python3-pip \
    python3-venv \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# Setup python virtual environment for Ubuntu PEP 668
# The ubuntu image needs pip to be in a venv
RUN python3 -m venv /home/$USERNAME/.venv
ENV PATH="/home/$USERNAME/.venv/bin:$PATH"


# Install python packages (as user)
COPY pip_requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt
