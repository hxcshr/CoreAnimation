//
//  CAModel.m
//  CoreAnimation
//
//  Created by 何学成 on 2017/9/17.
//  Copyright © 2017年 qudao.tbkf.net. All rights reserved.
//

#import "CAModel.h"

@implementation CAModel

- (instancetype)initWithTitle:(NSString *)title className:(NSString *)className
{
    self = [super init];
    if (self) {
        self.title = title;
        self.className = className;
    }
    return self;
}

@end
