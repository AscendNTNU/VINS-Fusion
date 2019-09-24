#include <ros/ros.h>

class VINS_node
{
private:
    ros::NodeHandle nh_;
    ros::Subscriber sub_imu;
    ros::Subscriber sub_feature;
    ros::Subscriber sub_img0;
    ros::Subscriber sub_img1;
    ros::Subscriber sub_restart;
    ros::Subscriber sub_imu_switch;
    ros::Subscriber sub_cam_switch;
    void img0_callback(const sensor_msgs::ImageConstPtr &img_msg);
    void img1_callback(const sensor_msgs::ImageConstPtr &img_msg);
    cv::Mat getImageFromMsg(const sensor_msgs::ImageConstPtr &img_msg);
    // extract images with same timestamp from two topics
    void imu_callback(const sensor_msgs::ImuConstPtr &imu_msg);
    void feature_callback(const sensor_msgs::PointCloudConstPtr &feature_msg);
    void restart_callback(const std_msgs::BoolConstPtr &restart_msg);
    void imu_switch_callback(const std_msgs::BoolConstPtr &switch_msg);
    void cam_switch_callback(const std_msgs::BoolConstPtr &switch_msg);

public:
    void sync_process();
    VINS_node(ros::NodeHandle &nh);
};
