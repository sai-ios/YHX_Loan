//
//  ActiveRepayTry.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ActiveRepayTry.h"

@implementation ActiveRepayTry

+(instancetype)tryWithDic:(NSDictionary *)dic{

    ActiveRepayTry *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    
    NSArray *feeArray = [dic objectForKey:@"feeArrayList"];
    NSMutableArray *feeList = [NSMutableArray array];
    for(int i = 0; i<[feeArray count];i++ ){
        if([feeArray[i] isKindOfClass:[NSDictionary class]]){
            FeeArray *fee = [FeeArray feeArrayWithDic:feeArray[i]];
            [feeList addObject:fee];
        }
    }
    model.feeArray = feeList;
    return model;
}

@end
@implementation FeeArray

+(instancetype)feeArrayWithDic:(NSDictionary *)dic{
    FeeArray *model = [self new];
    [model yy_modelSetWithDictionary:dic];
    return model;
}
@end
