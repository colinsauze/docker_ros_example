#!/bin/bash
/start_vnc.sh
export DISPLAY=:0
export ROS_DISTRO=noetic
source "/opt/ros/$ROS_DISTRO/setup.bash"
lxterminal &
roscore &
rosrun turtlesim turtlesim_node 

