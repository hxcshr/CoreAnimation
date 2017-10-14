//
//  HitTestingViewController.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/13.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "HitTestingViewController.h"

@interface HitTestingViewController ()

@property (nonatomic, strong) CALayer *greenLayer;
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation HitTestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _blueLayer = [CALayer layer];
    _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    _blueLayer.frame = CGRectMake(100, 100, 100, 100);
    [self.view.layer addSublayer:_blueLayer];
    
    _greenLayer = [CALayer layer];
    _greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    _greenLayer.frame = CGRectMake(160, 160, 100, 100);
    [self.view.layer addSublayer:_greenLayer];
    
//    _blueLayer.zPosition = 1.0;
}

#if 0

#pragma mark - 使用-containsPoint:方法判断
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CGPoint bluePoint = [_blueLayer convertPoint:point fromLayer:self.view.layer];
    CGPoint greenPoint = [_greenLayer convertPoint:point fromLayer:self.view.layer];
    if ([self.blueLayer containsPoint:bluePoint]) {
        if ([self.greenLayer containsPoint:greenPoint]) {
            NSLog(@"在重叠区域");
            return;
        }else{
            NSLog(@"在蓝色区域");
            return;
        }
    }else if ([_greenLayer containsPoint:greenPoint]){
        NSLog(@"在绿色区域");
        return;
    }else{
        NSLog(@"在其他区域");
        return;
    }
}

#else

#pragma mark - 使用-hitTest:方法判断
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *blueTouchLayer = [self.blueLayer hitTest:point];
    CALayer *greenTouchLayer = [_greenLayer hitTest:point];
    if (blueTouchLayer) {
        if (greenTouchLayer) {
            NSLog(@"在重叠区域");
        }else{
            NSLog(@"在蓝色区域");
        }
    }else if (greenTouchLayer) {
        NSLog(@"在绿色区域");
    }else{
        NSLog(@"在其他区域");
    }
}

#endif

@end
