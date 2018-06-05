//
//  ORCIDCardModel.m
//  YHX_Loan
//  orc 读取的身份证信息转换成功模型
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "ORCIDCardModel.h"

@implementation ORCIDCardModel

+(ORCIDCardModel *)orcIdCardWithDic :(ORCIDCardModel*)idCard dict:(id)dict {

    if(dict[@"words_result"]){
        if([dict[@"words_result"] isKindOfClass:[NSDictionary class]]){
            [dict[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                    if([key isEqualToString:@"姓名"])
                        idCard.name = obj[@"words"];
                    else if([key isEqualToString:@"出生"])
                        idCard.birthday = obj[@"words"];
                    else if([key isEqualToString:@"公民身份号码"])
                        idCard.idNumber = obj[@"words"];
                    else if([key isEqualToString:@"性别"])
                        idCard.sex = obj[@"words"];
                    else if([key isEqualToString:@"住址"])
                        idCard.address = obj[@"words"];
                    else if([key isEqualToString:@"民族"])
                        idCard.ethnic = obj[@"words"];
                    else if([key isEqualToString:@"失效日期"])
                        idCard.expiryDate = obj[@"words"];
                    else if([key isEqualToString:@"签发日期"])
                        idCard.signDate = obj[@"words"];
                    else if([key isEqualToString:@"签发机关"])
                        idCard.issueAuthority = obj[@"words"];
                }
            }];
        }
    }
    return idCard;
}

@end
