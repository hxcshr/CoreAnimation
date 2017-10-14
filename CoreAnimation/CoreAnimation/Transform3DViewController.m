//
//  Transform3DViewController.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/15.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "Transform3DViewController.h"

@interface Transform3DViewController ()

@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, strong) NSMutableArray<UIView *> *faces;

@property (nonatomic, strong) NSString *str;

@end

@implementation Transform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    for (NSInteger i = 0; i < 10000; i ++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.str = [NSString stringWithFormat:@"sasdf%ld",i];
        });
    }
    [self setupViews];
    [self setupTransforms];
}

- (void)setupTransforms{
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspective;
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    _faces[0].layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    _faces[1].layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    _faces[2].layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    _faces[3].layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    _faces[4].layer.transform = transform;
    
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    _faces[5].layer.transform = transform;
    
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    _containerView.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
//}

- (void)setupViews{
    UIView *containerView = [UIView new];
    containerView.frame = CGRectMake(0, 0, 200, 200);
    containerView.center = self.view.center;
    [self.view addSubview:containerView];
    _containerView = containerView;
    _faces = [NSMutableArray arrayWithCapacity:6];
//    NSArray *colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor blueColor]];
    for (NSInteger i = 0; i < 6; i++) {
        UILabel *view = [UILabel new];
        view.frame = containerView.bounds;
        [containerView addSubview:view];
        view.text = [NSString stringWithFormat:@"%ld",i+1];
        view.backgroundColor = [UIColor whiteColor];
        view.font = [UIFont systemFontOfSize:50];
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = [UIColor colorWithRed:i/5.0 green:i/5.0 blue:i/5.0 alpha:1.0];
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        [_faces addObject:view];
    }
}

@end
