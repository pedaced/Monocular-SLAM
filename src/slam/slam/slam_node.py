import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2

class SlamSubscriber(Node):
    def __init__(self):
        super().__init__('slam_subscriber')
        # 1. Subscribe to the camera topic
        self.subscription = self.create_subscription(
            Image, 'video_frames', self.listener_callback, 10)
        self.br = CvBridge()
        
        # 2. Setup Feature Detector (ORB is standard for Visual SLAM)
        self.orb = cv2.ORB_create()

    def listener_callback(self, data):
        # 3. Convert ROS image to OpenCV
        current_frame = self.br.imgmsg_to_cv2(data, 'bgr8')

        # 4. SLAM Pre-processing: Find keypoints
        keypoints, descriptors = self.orb.detectAndCompute(current_frame, None)

        # 5. Visualize the "SLAM Brain" seeing features
        frame_with_keys = cv2.drawKeypoints(current_frame, keypoints, None, color=(0, 255, 0))
        
        # Display the result (inside Docker, this requires X11 forwarding)
        cv2.imshow("SLAM Feature Tracking", frame_with_keys)
        cv2.waitKey(1)

def main(args=None):
    rclpy.init(args=args)
    node = SlamSubscriber()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()