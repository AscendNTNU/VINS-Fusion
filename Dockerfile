FROM ros:kinetic-perception
MAINTAINER Ascend NTNU "www.ascendntnu.no"

ENV CERES_VERSION="1.12.0"
ENV ROS_WORKSPACE_PATH=/root/catkin_workspace

RUN if [ "x$(nproc)" = "x1" ] ; then export USE_PROC=1 ; \
    else export USE_PROC=$(($(nproc)/2)) ; fi && \
    apt-get update -qq && apt-get install -yqq \
    build-essential \
    cmake \
    libgoogle-glog-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    ros-${ROS_DISTRO}-cv-bridge \
    ros-${ROS_DISTRO}-image-transport \
    ros-${ROS_DISTRO}-message-filters \
    ros-${ROS_DISTRO}-tf && \
    rm -rf /var/lib/apt/lists/* && \
    # Install Ceres with static version
    git clone https://ceres-solver.googlesource.com/ceres-solver && \
    cd ./ceres-solver && \
    git checkout tags/${CERES_VERSION} && \
    cmake . && make -j$(USE_PROC) install && \
    rm -rf ../../ceres-solver

RUN mkdir -p $ROS_WORKSPACE_PATH/src
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; catkin_init_workspace $ROS_WORKSPACE_PATH/src'

# Run caktin_make once without building any packages to create the setup.bash
# RUN /bin/bash -c '. /opt/ros/indigo/setup.bash; cd $ROS_WORKSPACE_PATH; catkin_make'

COPY ./ $ROS_WORKSPACE_PATH/src/jenkins_test
COPY ros_entrypoint.sh /
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; cd /root/catkin_workspace; catkin_make'
