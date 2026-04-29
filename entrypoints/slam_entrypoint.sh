#!/bin/bash
source /opt/ros/humble/setup.bash
source /slam-ros/install/setup.bash

echo "Attempting to launch SLAM..."
# This is where it's failing
ros2 run slam slam_node 

# Add this line! It forces the pane to stay open at a prompt 
# even after the 'ros2 run' command fails.
/bin/bash