//
//  ActiveRepay.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ActiveRepay.h"

@implementation ActiveRepay

+(instancetype)activeRepayWithDic:(NSDictionary *)dic{
    ActiveRepay *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    return model;
}

@end
