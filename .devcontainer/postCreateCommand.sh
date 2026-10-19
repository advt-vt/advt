#!/usr/bin/env bash

# These commands run inside the dev container right after the build finishes.

if [[ "$ADVT_PX4_INSTALL" == "true" ]]; then
    bash ./PX4-Autopilot/Tools/setup/ubuntu.sh
fi