//
//  LoanApplyBasicInfo.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanApplyBasicInfo.h"

@implementation LoanApplyBasicInfo

+(instancetype)loanRepayWithDic:(NSDictionary *)dic{
    LoanApplyBasicInfo *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    return model;
}

+(NSMutableArray *)loanListWithDic:(NSArray *)array{
    NSMutableArray *tableArray = [NSMutableArray array];
    for(int i = 0; i<[array count];i++ ){
        if([array[i] isKindOfClass:[NSDictionary class]]){
            LoanApplyBasicInfo *list = [LoanApplyBasicInfo loanRepayWithDic:array[i]];
            [tableArray addObject:list];
        }
    }
    
    return tableArray;
}
@end
