//
//  CAEmitterLayerVC.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/19.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "CAEmitterLayerVC.h"

@interface CAEmitterLayerVC ()

@end

@implementation CAEmitterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = CGRectMake(100, 100, 200, 200);
    [self.view.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.bounds.size.width / 2.0, emitter.bounds.size.height/2.0);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@""].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    emitter.emitterCells = @[cell];
    
}

@end
