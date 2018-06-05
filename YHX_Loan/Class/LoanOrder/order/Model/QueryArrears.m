//
//  QueryArrears.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "QueryArrears.h"

@implementation QueryArrears

+(instancetype)queryArrearsWithDic:(NSDictionary *)dic{
    QueryArrears *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    return model;
}

@end
