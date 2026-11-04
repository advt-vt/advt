#!/usr/bin/env bash

# you need the devcontainer CLI installed.
export PATH="$HOME/.devcontainers/bin:$PATH"
if ! command -v devcontainer &>/dev/null; then
    echo "devcontainer CLI not found, installing..."
    curl -fsSL https://raw.githubusercontent.com/devcontainers/cli/main/scripts/install.sh | sh -s -- --version 0.89.0
    export PATH="$HOME/.devcontainers/bin:$PATH"
fi

# just sets these to empty since not all of them need to be used
# since the GPU ones are being passed in as Run Args they can't be empty
export NVIDIA=""
export GPU="--env=cpu=true"
export GPU_EXTRA="--env=stuff=none"
export GPU_MOUNT="--env=stuff=none"
export GPU_LIBS="--env=stuff=none"

if [[ "$(uname -s)" == "Darwin" ]]; then
    # MacOS setup
    echo "MacOS Detected..."
    export DISPLAY="host.docker.internal:0"

elif grep -qi microsoft /proc/sys/kernel/osrelease; then
    # Using WSL2 forwarding
    echo "WSL2 Detected, forwarding GPU..."
    export DISPLAY=":0"

    # This works for AMD and for Intel GPUs, and is also needed for NVIDIA GPUs if using WSL
    export GPU="--device=/dev/dxg"
    export GPU_MOUNT="--mount=type=bind,source=/usr/lib/wsl,target=/usr/lib/wsl,readonly"
    export GPU_LIBS="--env=LD_LIBRARY_PATH=/usr/lib/wsl/lib"
    export GALLIUM_DRIVER="d3d12"

    if command -v nvidia-smi &>/dev/null; then
        echo "NVIDIA GPU detected on WSL, forwarding..."
        if ! command -v nvidia-ctk >/dev/null 2>&1; then
            echo "Installing the NVIDIA Docker Toolkit..."
            .devcontainer/nvidia_install.sh
        fi
        
        export GPU_EXTRA="--gpus=all"
        export NVIDIA="all"
    fi

elif command -v nvidia-smi &>/dev/null; then
    echo "NVIDIA GPU detected on Linux, forwarding..."
    if ! command -v nvidia-ctk >/dev/null 2>&1; then
        echo "Installing the NVIDIA Docker Toolkit..."
        .devcontainer/nvidia_install.sh
    fi
    export GPU="--gpus=all"
    export NVIDIA="all"

elif [ -d /dev/dri ] && command -v apt &> /dev/null; then
    # AMD or Intel GPU on Linux
    echo "Native Linux install detected, forwarding GPU..."
    export GPU="--device=/dev/dri"

else
    echo "No GPU detected defaulting to CPU"
fi

# opens vscode and runs the container
cd ~/advt && git pull && devcontainer up --workspace-folder . --remove-existing-container && code .