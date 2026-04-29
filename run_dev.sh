#!/bin/bash

# Give Docker permission to show windows on your host screen
xhost +local:docker > /dev/null

docker run -it --rm \
    --name slam_container \
    --privileged \
    --net=host \
    --device=/dev/video0:/dev/video0 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $(pwd):/slam-ros \
    slam-ros /bin/bash /slam-ros/entrypoints/master_entrypoint.sh