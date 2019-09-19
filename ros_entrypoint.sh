#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"


if [[ "$1" = "tests" ]]; then
	echo "#### RUNNING ROS UNIT TESTS ####"
	cd /root/catkin_workspace
	roscore&
	catkin_make run_tests
else
	exec "$@"
fi
