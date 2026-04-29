#!/bin/bash
source /opt/ros/humble/setup.bash
source /slam-ros/install/setup.bash

echo "Starting Camera Node..."
# We use a subshell or just run it directly
ros2 run camera camera_node

echo "Camera node stopped! Keeping pane open for debugging..."
/bin/bash # <--- THIS IS CRITICAL