//
//  CAShapeLayerVC.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/17.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//
/*
 CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。你指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后CAShapeLayer就自动渲染出来了。当然，你也可以用Core Graphics直接向原始的CALyer的内容中绘制一个路径，相比直下，使用CAShapeLayer有以下一些优点：
 渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
 高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
 不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。你的图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉（如我们在第二章所见）。
 不会出现像素化。当你给CAShapeLayer做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。
 */

#import "CAShapeLayerVC.h"

@interface CAShapeLayerVC ()

@end

@implementation CAShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint center = self.view.center;
    [path moveToPoint:CGPointMake(center.x + 25, 100)];
    [path addArcWithCenter:CGPointMake(center.x, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(center.x, 125)];
    [path addLineToPoint:CGPointMake(center.x, 175)];
    [path addLineToPoint:CGPointMake(center.x - 25, 225)];
    [path moveToPoint:CGPointMake(center.x, 175)];
    [path addLineToPoint:CGPointMake(center.x + 25, 225)];
    [path moveToPoint:CGPointMake(center.x - 50, 150)];
    [path addLineToPoint:CGPointMake(center.x + 50, 150)];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;

    [self.view.layer addSublayer:shapeLayer];
    
    
    //圆角
    UIView *rview = [UIView new];
    rview.frame = CGRectMake(0, 0, 100, 100);
    rview.center = self.view.center;
    [self.view addSubview:rview];
    rview.clipsToBounds = YES;
    
    CAShapeLayer *rshapeLayer = [CAShapeLayer layer];
    rshapeLayer.fillColor = [UIColor clearColor].CGColor;
    rshapeLayer.strokeColor = [UIColor blueColor].CGColor;
    rshapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:rview.bounds cornerRadius:10].CGPath;
    [rview.layer addSublayer:rshapeLayer];
    
    //指定哪个角是圆角
    /*
     CGRect rect = CGRectMake(50, 50, 100, 100);
     CGSize radii = CGSizeMake(20, 20);
     UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
     //create path
     UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
     */
    
    //使用图片画的圆角 
    /*
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.0, 0.0);
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    blueLayer.contents = (__bridge id)[UIImage imageNamed:@"Circle.png"].CGImage;
    //add it to our view
    [self.layerView.layer addSublayer:blueLayer];
     */
    
}

@end
