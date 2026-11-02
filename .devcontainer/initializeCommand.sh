#!/usr/bin/env bash

# These commands run on the host right before the build starts.

# If macOS then open XQuartz and add localhost to xhost
os="$(uname -s)"
if [ "$os" = "Darwin" ]; then
    open -ga XQuartz
    sleep 2
    DISPLAY=:0 /opt/X11/bin/xhost +localhost || true
fi
# If linux add user to xhost
if [ "$os" = "Linux" ]; then
    xhost +SI:localuser:$(whoami) || true
fi
