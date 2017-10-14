#import <UIKit/UIKit.h>

#import <QuartzCore/CADisplayLink.h>

#import "FallingButton.h"

@class CMMotionManager;
@interface ViewController : UIViewController <UIAccelerometerDelegate> {
	CADisplayLink *displayLink;
	ChipmunkSpace *space;
	FallingButton *fallingButton;
}

@property (nonatomic, strong) CMMotionManager *motion;

@end

