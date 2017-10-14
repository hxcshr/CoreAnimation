//
//  CAModel.h
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/17.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *className;

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className;


@end
