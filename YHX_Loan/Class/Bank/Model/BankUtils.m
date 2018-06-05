//
//  BankUtils.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/22.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "BankUtils.h"
static BankUtils * _manage;

@implementation BankUtils

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    // 一次函数
    dispatch_once(&onceToken, ^{
        if (_manage == nil) {
            _manage = [super allocWithZone:zone];
        }
    });
    return _manage;
}

+(instancetype)shareInstance
{
    return [[self alloc] init];
}

-(void)execute:(NSString*)bankNumber success:(void (^ __nullable)(BankMode *bank))success failed:(void (^ __nullable)(NSString *msssage))failed{
    @try {
     
    NSString *url = @"https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardBinCheck=true&cardNo=";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [EasyShowLodingView showLodingText:@""];
    [session GET:[url stringByAppendingString:bankNumber] parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@",responseObject);
             // 关闭HUD
             [EasyShowLodingView hidenLoding];
             BankRequest *bankResult = [BankRequest bankWithDic:responseObject];
            
             if(bankResult.validated == true){
                 BankMode *bank = [[BankMode alloc]init];
                 bank.bankCardNumber = bankResult.key;
                 // 获取银行代码字典
                 NSString *path = [[NSBundle mainBundle]pathForResource:@"bankName.plist" ofType:nil];
                 NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                 // 获取银行名称
                 bank.bankName = [dict objectForKey:bankResult.bank];
                 // 银行类型
                 bank.cardType =  bankResult.cardType;
                 success(bank);
                 
             }else{
               failed(@"银行卡卡片有误或者没有收录，请更换卡片!");
             }
           
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [EasyShowLodingView hidenLoding];
             [EasyShowTextView showText:@"请求失败!"];
             NSLog(@"failure--%@",error);
             failed(@"请求失败!");
         }];
    }
    @catch (NSException *exception) {
        NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
        failed(@"银行卡输入有误!");
    }
    @finally {
    }
}

@end

@implementation BankMode
@end
@implementation BankRequest

+(instancetype)bankWithDic:(NSDictionary *)dic{
    //    UserModel *user = [self share];
    BankRequest *bank = [self new];
    [bank yy_modelSetWithDictionary:dic];
    return bank;
}
@end
