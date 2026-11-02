#!/usr/bin/env bash

# These commands run on the host right before the build starts.

# If macOS then open XQuartz and add localhost to xhost
if [ "$(uname)" = "Darwin" ]; then
    open -ga XQuartz
    sleep 2
    DISPLAY=:0 /opt/X11/bin/xhost +localhost || true
# otherwise add user to xhost
else
    xhost +SI:localuser:$(whoami) || true
fi
