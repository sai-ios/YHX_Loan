//
//  UserModel.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/18.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "UserModel.h"
// 创建静态对象 防止外部访问
static UserModel * _user;
@implementation UserModel
+(instancetype)userWithDic:(NSDictionary *)dic{
//    UserModel *user = [self share];
     UserModel *user = [self new];
    [user yy_modelSetWithDictionary:dic];
    return user;
}

@end

@implementation UserBasicInfo

@end

@implementation WorkInfo

@end

@implementation BankCard
+(instancetype)bankWithDic:(NSDictionary *)dic{
    BankCard *bank = [self new];
    [bank yy_modelSetWithDictionary:dic];
    return bank;
}
@end

@implementation Relation

- (instancetype)init
{
    self = [super init];
    if (self) {     
        _rowNo = @"";
        _relationCustomerName = @"";
        _relationCustomerMobile = @"";
        _relationName = @"";
        _relationCustomerIdCardNumber = @"";
        _relationCustomerTel = @"";
    }
    return self;
}

@end
