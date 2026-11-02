#!/usr/bin/env bash

# you need the devcontainer CLI installed in order to specify a different .json file for the container
if ! command -v devcontainer &>/dev/null; then
    echo "devcontainer CLI not found, installing..."
    curl -fsSL https://raw.githubusercontent.com/devcontainers/cli/main/scripts/install.sh | sh -s -- --version 0.89.0
    export PATH="$HOME/.devcontainers/bin:$PATH"
fi


if command -v nvidia-smi &>/dev/null && command -v apt &> /dev/null; then
    echo "NVIDIA GPU detected, forwarding..."
    if ! command -v nvidia-ctk >/dev/null 2>&1; then
        echo "Intstalling the NVIDIA Docker Toolkit..."
        .devcontainer/gpu/nvidia_install.sh
    fi
    devcontainer up --workspace-folder . --config ./.devcontainer/gpu/nvidia/devcontainer.json

elif [ -e /dev/kfd ] && command -v apt &> /dev/null; then
    echo "AMD GPU detected, forwarding..."
    devcontainer up --workspace-folder . --config ./.devcontainer/gpu/amd/devcontainer.json

elif [ -d /dev/dri ] && command -v apt &> /dev/null; then
    echo "Intel GPU detected, forwarding..."
    devcontainer up --workspace-folder . --config ./.devcontainer/gpu/intel/devcontainer.json

else
    echo "No GPU detected defaulting to CPU"
    devcontainer up --workspace-folder . --config ./.devcontainer/devcontainer.json
fi

# opens vscode
cd ~/advt && git pull && code .