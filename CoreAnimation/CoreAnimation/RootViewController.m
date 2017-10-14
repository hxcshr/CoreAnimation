//
//  ViewController.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/12.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "RootViewController.h"
#import "CAModel.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation RootViewController

static NSString *kCell = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self setupData];
}

- (void)setupData{
    _dataArray = [NSMutableArray array];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"Hit Testing" className:@"HitTestingViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"corner Radius" className:@"CornerViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"图片拉伸过滤" className:@"FilterViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CATransform3D" className:@"Transform3DViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CALayer" className:@"CALayerViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"隐式动画" className:@"CALayerViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"Chipmunk" className:@"ChipmunkViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"CoreGraphics" className:@"CoreGraphicsViewController"]];
    [_dataArray addObject:[[CAModel alloc]initWithTitle:@"物理引擎" className:@"ViewController"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView dalegate datasoruce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    CAModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.title;
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
