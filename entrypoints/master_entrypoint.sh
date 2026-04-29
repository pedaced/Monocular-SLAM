#!/bin/bash
source /opt/ros/humble/setup.bash
colcon build
source install/setup.bash

tmux start-server

# 1. Create the session with the Camera (Top Left)
tmux new-session -d -s slam_session "/bin/bash /slam-ros/entrypoints/camera_entrypoint.sh"

# 2. Split vertically for SLAM (Top Right)
tmux split-window -h -t slam_session "/bin/bash /slam-ros/entrypoints/slam_entrypoint.sh"

# 3. Split horizontally to create a small 'Control' pane at the bottom
# The 'kill-session' command ensures that when this bash shell exits, everyone dies.
tmux split-window -v -p 20 -t slam_session "bash -c 'echo \"CONTROL TERMINAL: Type exit to shutdown all nodes.\"; bash; tmux kill-session -t slam_session'"

# 4. Attach
tmux attach-session -t slam_session