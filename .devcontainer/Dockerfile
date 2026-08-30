FROM mcr.microsoft.com/devcontainers/base:ubuntu

USER root

# The image we are using ships with a non-root user named vscode
# We can change this if needed (make sure to also change devcontainer.json to match)
ARG USERNAME=vscode

ENV SHELL=/bin/bash

RUN apt-get update \
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
