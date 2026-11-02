#!/usr/bin/env bash

# These commands run on the host right before the build starts.

xhost +SI:localuser:$(whoami) || true
