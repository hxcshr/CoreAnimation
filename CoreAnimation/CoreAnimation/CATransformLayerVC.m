//
//  CATransformLayerVC.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/18.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "CATransformLayerVC.h"

@interface CATransformLayerVC ()

@property (nonatomic, strong) CATransformLayer *cube1;

@end

@implementation CATransformLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1 / 500.0;
    self.view.layer.sublayerTransform = pt;
    
    
    CGPoint center = self.view.center;
    CATransformLayer *transfromLayer = [CATransformLayer layer];
    transfromLayer.frame = CGRectMake( center.x - 100, center.y - 100, 100, 100);
    
    //add cube face 1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [transfromLayer addSublayer:[self faceWithTransform:ct]];
    //add cube face 2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [transfromLayer addSublayer:[self faceWithTransform:ct]];
    //add cube face 3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [transfromLayer addSublayer:[self faceWithTransform:ct]];
    //add cube face 4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [transfromLayer addSublayer:[self faceWithTransform:ct]];
    //add cube face 5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [transfromLayer addSublayer:[self faceWithTransform:ct]];
    //add cube face 6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [transfromLayer addSublayer:[self faceWithTransform:ct]];
    
    transfromLayer.position = center;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, -100, 0);
    
    transfromLayer.transform = transform;
    [self.view.layer addSublayer:transfromLayer];
    _cube1 = transfromLayer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CATransform3D transform = _cube1.transform;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 1);
    //transform = CATransform3DRotate(transform, M_PI_4, 1, 0, 0);
    _cube1.transform = transform;
}

- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    //create cube face layer
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(0, 0, 100, 100);
    
    //apply a random color
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //apply the transform and return
    face.transform = transform;
    return face;
}

@end
