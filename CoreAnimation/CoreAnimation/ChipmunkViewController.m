//
//  ChipmunkViewController.m
//  CoreAnimationTest
//
//  Created by mengkezheng on 2017/9/26.
//  Copyright © 2017年 com.qudao. All rights reserved.
//

#import "ChipmunkViewController.h"
#import "chipmunk.h"

@interface Crate : UIView

@property (nonatomic, assign) cpBody *body;
@property (nonatomic, assign) cpShape *shape;

@end

@implementation Crate

#define MASS 100

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.body = cpBodyNew(MASS, cpMomentForBox(MASS, frame.size.width, frame.size.height));
        
        cpVect corners[] = {
            cpv(0, 0),
            cpv(0, frame.size.height),
            cpv(frame.size.width, frame.size.height),
            cpv(frame.size.width, 0),
        };

        cpTransform transform = CGAffineTransformIdentity;

        self.shape = cpPolyShapeNew(self.body, 4, corners, transform, 0);
        
        cpShapeSetFriction(self.shape, 0.5);
        cpShapeSetElasticity(self.shape, 0.8);
        
        cpShapeSetUserData(self.shape, (__bridge void *)self);

        
        cpBodySetPosition(self.body, cpv(frame.origin.x + frame.size.width/2.0, 300 - frame.origin.y - frame.size.height/2.0));
        
        
    }
    return self;
}

- (void)dealloc{
    cpShapeFree(_shape);
    cpBodyFree(_body);
}

@end



@interface ChipmunkViewController ()<UIAccelerometerDelegate>

@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign) cpSpace *space;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval lastStep;

@end

@implementation ChipmunkViewController

#define GRAVITY 1000





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.frame = CGRectMake(0, 0, 300, 300);
    containerView.center = self.view.center;
    [self.view addSubview:containerView];
    _containerView = containerView;
    _containerView.layer.geometryFlipped = YES;
    
    
    self.space = cpSpaceNew();
    cpSpaceSetGravity(self.space, cpv(0, -GRAVITY));
    

    
    [self addWallShapeWithStart:cpv(0, 0) end:cpv(300, 0)];
    [self addWallShapeWithStart:cpv(300, 0) end:cpv(300, 300)];
    //[self addWallShapeWithStart:cpv(300, 300) end:cpv(0, 300)];
    [self addWallShapeWithStart:cpv(0, 300) end:cpv(0, 0)];
    

    [self addCrateWithFrame:CGRectMake(0, 0, 32, 32)];
    [self addCrateWithFrame:CGRectMake(32, 0, 64, 64)];
    [self addCrateWithFrame:CGRectMake(64, 0, 32, 32)];
    
    self.lastStep = CACurrentMediaTime();
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
//    [UIAccelerometer sharedAccelerometer].delegate = self;
//    [UIAccelerometer sharedAccelerometer].updateInterval = 1/60.0;
    
}

//- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
//{
//    //update gravity
//    cpSpaceSetGravity(self.space, cpv(acceleration.y * GRAVITY, -acceleration.x * GRAVITY));
//}

void updateShape(cpShape *shape, void *unused){
    Crate *crate = (__bridge Crate *)cpShapeGetUserData(shape);
    
    cpBody *body = cpShapeGetBody(shape);
    
//    crate.center = cpBodyGetPosition(body);
    
    cpVect center = cpBodyGetPosition(body);
    
    //crate.center = center;
    
    crate.transform = CGAffineTransformRotate(CGAffineTransformMakeTranslation(center.x, center.y), cpBodyGetAngle(body));

}

- (void)step:(CADisplayLink *)timer{
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    
    cpSpaceStep(self.space, stepDuration);
    
    cpSpaceEachShape(self.space, &updateShape, NULL);
}

- (void)addCrateWithFrame:(CGRect)frame{
    Crate *crate = [[Crate alloc]initWithFrame:frame];
    [self.containerView addSubview:crate];
    cpSpaceAddBody(self.space, crate.body);
    cpSpaceAddShape(self.space, crate.shape);
}

- (void)addWallShapeWithStart:(cpVect)start end:(cpVect)end{
    cpBody *body = cpSpaceGetStaticBody(self.space);
    cpShape *wall = cpSegmentShapeNew(body, start, end, 1);
    //碰撞类型
    cpShapeSetCollisionType(wall, 2);
    //摩擦力
    cpShapeSetFriction(wall, 0.5);
    //变形
    cpShapeSetElasticity(wall, 0.8);
    cpSpaceAddShape(self.space, wall);
}









@end
