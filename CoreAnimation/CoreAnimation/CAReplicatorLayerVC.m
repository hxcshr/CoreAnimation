//
//  CAReplicatorLayerVC.m
//  CoreAnimationTest
//
//  Created by mengkezheng on 2017/9/19.
//  Copyright © 2017年 com.qudao. All rights reserved.
//

#import "CAReplicatorLayerVC.h"

@interface CAReplicatorLayerVC ()

@end

@implementation CAReplicatorLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGPoint center = self.view.center;
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = CGRectMake(center.x - 100, center.y - 100 - 50 - 100 * sqrt(2) / 2 - 50, 200, 200);
    [self.view.layer addSublayer:replicator];

    replicator.instanceCount = 8;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 170, 0);
    transform = CATransform3DRotate(transform, M_PI / 4.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -170, 0);
    replicator.instanceTransform = transform;
    
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    [replicator addSublayer:layer];


}

@end
