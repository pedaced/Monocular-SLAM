#!/bin/bash

# Allow Docker to talk to your display if needed

xhost +local:docker

docker run -it --rm \
    --name camera_publisher \
    --device=/dev/video0:/dev/video0 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $(pwd):/slam-ros \
    --net=host \
    slam-ros /slam-ros/entrypoints/master_entrypoint.sh

