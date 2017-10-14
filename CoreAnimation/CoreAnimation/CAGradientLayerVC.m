//
//  CAGradientLayerVC.m
//  CoreAnimationTest
//
//  Created by mengkezheng on 2017/9/19.
//  Copyright © 2017年 com.qudao. All rights reserved.
//

#import "CAGradientLayerVC.h"

@interface CAGradientLayerVC ()

@end

@implementation CAGradientLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 100, 200, 200);
    [self.view.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    //渐变方向是由startPoint和endPoint的连线决定的
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    
    
    //多重渐变
    /*
     colors属性可以包含很多颜色，所以创建一个彩虹一样的多重渐变也是很简单的。默认情况下，这些颜色在空间上均匀地被渲染，但是我们可以用locations属性来调整空间。locations属性是一个浮点数值的数组（以NSNumber包装）。这些浮点数定义了colors属性中每个不同颜色的位置，同样的，也是以单位坐标系进行标定。0.0代表着渐变的开始，1.0代表着结束。
     locations数组并不是强制要求的，但是如果你给它赋值了就一定要确保locations的数组大小和colors数组大小一定要相同，否则你将会得到一个空白的渐变。+
     

     */
    CAGradientLayer *rainbowLayer = [CAGradientLayer layer];
    rainbowLayer.frame = CGRectMake(100, 350, 200, 200);
    [self.view.layer addSublayer:rainbowLayer];
    //
    rainbowLayer.colors =@[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor cyanColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    
    //rainbowLayer.locations
    rainbowLayer.locations = @[@0.14, @0.28, @0.4,@0.54,@0.68,@0.84,@1.0];
    
    rainbowLayer.startPoint = CGPointMake(0, 0);
    rainbowLayer.endPoint = CGPointMake(1, 1);

}

@end
