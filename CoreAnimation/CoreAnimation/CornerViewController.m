//
//  CornerViewController.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/14.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "CornerViewController.h"

@interface CornerViewController ()

@property (nonatomic, strong) UIView *layerView1;
@property (nonatomic, strong) UIView *layerView2;

@end

@implementation CornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    _layerView1 = [[UIView alloc]initWithFrame:CGRectMake(40, 80, 100, 100)];
    _layerView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_layerView1];
    UIView *redView1 = [[UIView alloc]initWithFrame:CGRectMake(-20, 80, 40, 40)];
    redView1.backgroundColor = [UIColor redColor];
    [_layerView1 addSubview:redView1];
    

    _layerView2 = [[UIView alloc]initWithFrame:CGRectMake(180, 80, 100, 100)];
    _layerView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_layerView2];
    UIView *redView2 = [[UIView alloc]initWithFrame:CGRectMake(-20, 80, 40, 40)];
    redView2.backgroundColor = [UIColor redColor];
    [_layerView2 addSubview:redView2];
    
    self.layerView1.layer.cornerRadius = 10.0;
    self.layerView2.layer.cornerRadius = 10.0;
    
    self.layerView2.clipsToBounds = YES;
    //                   ||
    self.layerView2.layer.masksToBounds = YES;

    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView2.layer.borderWidth = 5.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
