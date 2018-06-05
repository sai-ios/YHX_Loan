//
//  DataManage.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/21.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "DataManage.h"
// 创建静态对象 防止外部访问
static DataManage * _manage;

@implementation DataManage
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    // 一次函数
    dispatch_once(&onceToken, ^{
        if (_manage == nil) {
            _manage = [super allocWithZone:zone];
        }
    });
    
    return _manage;
}

+ (instancetype)share{
    
    return  [[self alloc] init];
}


@end
