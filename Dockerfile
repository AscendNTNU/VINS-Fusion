FROM ros:kinetic-ros-base
MAINTAINER Ascend NTNU "www.ascendntnu.no"

ENV CERES_VERSION="1.12.0"
ENV ROS_WORKSPACE_PATH=/root/catkin_workspace

RUN apt-get update -qq && apt-get install -yqq \
    build-essential \
    cmake \
    libgoogle-glog-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev

WORKDIR /root
RUN git clone https://ceres-solver.googlesource.com/ceres-solver
RUN cd ./ceres-solver && git checkout tags/${CERES_VERSION} && cmake . && make install

RUN mkdir -p $ROS_WORKSPACE_PATH/src
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; catkin_init_workspace $ROS_WORKSPACE_PATH/src'

# Run caktin_make once without building any packages to create the setup.bash
# RUN /bin/bash -c '. /opt/ros/indigo/setup.bash; cd $ROS_WORKSPACE_PATH; catkin_make'

COPY ./ $ROS_WORKSPACE_PATH/src/jenkins_test
COPY ros_entrypoint.sh /
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; cd /root/catkin_workspace; catkin_make'
