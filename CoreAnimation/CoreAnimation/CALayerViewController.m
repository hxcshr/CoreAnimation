//
//  CALayerViewController.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/17.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "CALayerViewController.h"
#import "CAModel.h"

@interface CALayerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<CAModel *> *dataArray;

@end

@implementation CALayerViewController


static NSString *kCellIdentifier = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [self setupData];
}

- (void)setupData{
    _dataArray = [NSMutableArray arrayWithCapacity:10];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CAShapeLayer" className:@"CAShapeLayerVC"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CATextLayer" className:@"CATextLayerVC"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CATransformLayer" className:@"CATransformLayerVC"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CAGradientLayer" className:@"CAGradientLayerVC"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CAReplicatorLayer" className:@"CAReplicatorLayerVC"]];
    //[_dataArray addObject:[[CAModel alloc]initWithTitle:@"CAScrollLayer" className:@""]];
    //[_dataArray addObject:[[CAModel alloc]initWithTitle:@"CATiledLayer" className:@"CATiledLayerVC"]];
    //[_dataArray addObject:[[CAModel alloc]initWithTitle:@"CAEmitterLayer" className:@""]];
    //[_dataArray addObject:[[CAModel alloc]initWithTitle:@"CAEAGLLayer" className:@""]];
    //[_dataArray addObject:[[CAModel alloc]initWithTitle:@"AVPlayerLayer" className:@""]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CAModel *model = _dataArray[indexPath.row];
    NSString *className = model.className;
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = model.title;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
