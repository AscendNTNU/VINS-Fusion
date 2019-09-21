#include <ros/ros.h>

class VINS_node {
private:
    ros::NodeHandle nh_;
    ros::Subscriber sub_imu;        //  = n.subscribe(IMU_TOPIC, 2000, imu_callback, ros::TransportHints().tcpNoDelay());
    ros::Subscriber sub_feature;    //  = n.subscribe("/feature_tracker/feature", 2000, feature_callback);
    ros::Subscriber sub_img0;       //  = n.subscribe(IMAGE0_TOPIC, 100, img0_callback);
    ros::Subscriber sub_img1;       //  = n.subscribe(IMAGE1_TOPIC, 100, img1_callback);
    ros::Subscriber sub_restart;    //  = n.subscribe("/vins_restart", 100, restart_callback);
    ros::Subscriber sub_imu_switch; // = n.subscribe("/vins_imu_switch", 100, imu_switch_callback);
    ros::Subscriber sub_cam_switch; // = n.subscribe("/vins_cam_switch", 100, cam_switch_callback);
public:
    VINS_node(ros::NodeHandle& nh);
};