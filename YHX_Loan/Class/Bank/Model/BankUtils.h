//
//  BankUtils.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/22.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
#define Binding 0 //绑定
#define unBinding 1 //解绑

@class BankMode;
@interface BankUtils : NSObject

+(instancetype)shareInstance;

-(void)execute:(NSString*)bankNumber success:(void (^ __nullable)(BankMode *bank))success failed:(void (^ __nullable)(NSString *msssage))failed;

@end

@interface BankMode : NSObject

@property(nonatomic, strong) NSString *bankName;            // 开户行
@property(nonatomic, strong) NSString *bankCardNumber;      // 银行卡号
@property(nonatomic, strong) NSString *cardType;            // 行卡类型"CC：贷记卡  DC：借记卡
@end

@interface BankRequest : NSObject
@property(nonatomic, strong) NSString *bank;
@property(nonatomic, strong) NSString *cardType;
@property(nonatomic, strong) NSString *key;
@property(nonatomic, strong) NSString *stat;
@property(nonatomic, assign) Boolean validated;

+(instancetype)bankWithDic:(NSDictionary *)dic;
@end
