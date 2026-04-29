FROM ros:humble-ros-base

RUN apt-get update && apt-get install -y \
    # 1. Python Tools
    python3-pip \
    # 2. The Bridge (Essential for your video goal)
    ros-humble-cv-bridge \
    # 3. Message Definitions (The "dictionary" for your nodes)
    ros-humble-sensor-msgs \
    ros-humble-std-msgs \
    # 4. Build Tool (Needed to compile your workspace later)
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y tmux && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    ros-humble-rviz2 \
    libqt5gui5 \
    libxcb-xinerama0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR slam-ros

COPY entrypoints/ /entrypoints
RUN chmod +x /entrypoints/*.sh
