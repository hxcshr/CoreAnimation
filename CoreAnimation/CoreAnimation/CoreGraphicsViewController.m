//
//  CoreGraphicsViewController.m
//  CoreAnimationTest
//
//  Created by mengkezheng on 2017/9/27.
//  Copyright © 2017年 com.qudao. All rights reserved.
//

#import "CoreGraphicsViewController.h"

@interface DrawingView : UIView

@end

@interface DrawingView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DrawingView

+ (Class)layerClass{
    return [CAShapeLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.path = [[UIBezierPath alloc]init];
//        self.path.lineJoinStyle = kCGLineJoinRound;
//        self.path.lineCapStyle = kCGLineCapRound;
//        self.path.lineWidth = 5;
        
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        
        shapeLayer.lineWidth = 5;
    }
    return self;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path addLineToPoint:point];
    
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
    
}
// [self setNeedsDisplay];
//                |
//                V
//- (void)drawRect:(CGRect)rect{
//    [[UIColor clearColor] setFill];
//    [[UIColor redColor] setStroke];
//    [self.path stroke];
//}

@end



@interface CoreGraphicsViewController ()

@end

@implementation CoreGraphicsViewController

- (void)loadView{
    DrawingView *view = [[DrawingView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
