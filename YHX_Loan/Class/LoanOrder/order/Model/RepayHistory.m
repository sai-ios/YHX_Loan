//
//  RepayHistory.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "RepayHistory.h"

@implementation RepayHistory

+(instancetype)historyWithDic:(NSDictionary *)dic{
    RepayHistory *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    return model;
}

+(NSArray *)historyArrayWithDic:(NSArray *)array{
    NSMutableArray *historyList = [NSMutableArray array];
    for(int i = 0; i<[array count];i++ ){
        if([array[i] isKindOfClass:[NSDictionary class]]){
        RepayHistory *history = [RepayHistory historyWithDic:array[i]];
        [historyList addObject:history];
        }
    }
    
    return historyList;
}

@end
