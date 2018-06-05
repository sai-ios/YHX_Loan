//
//  GetLoanListServer.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "GetLoanListServer.h"
#import "LoanApplyBasicInfo.h"
static GetLoanListServer * loanListServer;
@implementation GetLoanListServer

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    // 一次函数
    dispatch_once(&onceToken, ^{
        if (loanListServer == nil) {
            loanListServer = [super allocWithZone:zone];
        }
    });
    return loanListServer;
}

+(instancetype)shareInstance
{
    return [[self alloc] init];
}

+(void)getLoanListsuccess:(void (^ __nullable)(NSArray *loanList))success failed:(void (^ __nullable)(NSString *msssage))failed{
    @try {
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        session.requestSerializer=[AFJSONRequestSerializer serializer];
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        
        UserModel *user = [DataManage share].userModel;
        
        [parames setObject:user.idCardNumber forKey: @"idCardNumber"];                  // 身份证号
        [parames setObject:user.realName forKey: @"realName"];                          //
        [parames setObject:user.loginName forKey: @"mobile"];
        [parames setObject:user.loginName forKey: @"loginName"];
        [session POST:url_getLoanList parameters:parames progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                     // 显示登录成功toast
                     NSArray *result = [responseObject objectForKey:@"result"];
                     success([LoanApplyBasicInfo loanListWithDic:result]);
                 }else{
                     [EasyShowTextView showErrorText:@"加载失败!"];
                 }
  
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [EasyShowTextView showText:@"请求失败!"];
                 NSLog(@"failure--%@",error);
                 failed(@"请求失败!");
             }];
    }
    @catch (NSException *exception) {
        NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
        failed(@"数据有误!");
    }
    @finally {
    }
}

@end
