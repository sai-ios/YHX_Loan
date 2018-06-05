//
//  Fee.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "Fee.h"

@implementation Fee

+(instancetype)feeWithDic:(NSDictionary *)dic{
    Fee *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    return model;
}

@end

