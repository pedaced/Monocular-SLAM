import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Image
import cv2
from cv_bridge import CvBridge

class WebcamPublisher(Node):
    def __init__(self):
        super().__init__('webcam_publisher')
        # Create a publisher on the "video_frames" topic
        self.publisher_ = self.create_publisher(Image, 'video_frames', 10)
        
        # Timer to call the function every 0.1 seconds (10 FPS)
        self.timer = self.create_timer(0.1, self.timer_callback)
        
        # Initialize OpenCV video capture (0 is usually the built-in webcam)
        self.cap = cv2.VideoCapture(0)
        self.br = CvBridge()

    def timer_callback(self):
        ret, frame = self.cap.read()
        
        if ret:
            # Convert OpenCV image to ROS Image message
            msg = self.br.cv2_to_imgmsg(frame, encoding="bgr8")
            self.publisher_.publish(msg)
            self.get_logger().info('Publishing video frame')
            print('Published the image from webcam ')

def main(args=None):
    rclpy.init(args=args)
    webcam_publisher = WebcamPublisher()
    rclpy.spin(webcam_publisher)
    webcam_publisher.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()