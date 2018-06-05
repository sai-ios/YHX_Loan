//
//  XYRepayPlan.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "XYRepayPlan.h"

@implementation XYRepayPlan

+(instancetype)xyRepayWithDic:(NSDictionary *)dic{
    XYRepayPlan *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    return model;
}

+(NSMutableArray *)repayPlanArrayWithDic:(NSArray *)array{
    NSMutableArray *planArray = [NSMutableArray array];
    for(int i = 0; i<[array count];i++ ){
        if([array[i] isKindOfClass:[NSDictionary class]]){
            XYRepayPlan *history = [XYRepayPlan xyRepayWithDic:array[i]];
            [planArray addObject:history];
        }
    }
    
    return planArray;
}

@end

