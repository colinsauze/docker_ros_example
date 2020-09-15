#!/bin/bash
export ROS_DISTRO=noetic
source "/opt/ros/$ROS_DISTRO/setup.bash"
roscore &
rosrun turtlesim turtlesim_node
