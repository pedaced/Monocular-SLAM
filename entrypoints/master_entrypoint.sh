#!/bin/bash
source /opt/ros/humble/setup.bash
colcon build
source install/setup.bash

tmux start-server

# Pane 0: Camera
tmux new-session -d -s slam_session "/bin/bash /slam-ros/entrypoints/camera_entrypoint.sh"

# Pane 1: SLAM (Vertical split under camera)
tmux split-window -v -t slam_session "/bin/bash /slam-ros/entrypoints/slam_entrypoint.sh"

# Pane 2: RViz (Horizontal split to the right)
tmux split-window -h -p 60 -t slam_session "source install/setup.bash && rviz2"

# Pane 3: Control (Vertical split under SLAM)
tmux select-pane -t 1
tmux split-window -v -p 30 -t slam_session "bash -c 'echo \"CONTROLS: Ctrl+b then arrows to move. Type exit here to quit.\"; bash; tmux kill-session -t slam_session'"

tmux attach-session -t slam_session