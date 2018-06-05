//
//  UserDataRefreshHttp.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/6/1.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "UserDataRefreshHttp.h"

@implementation UserDataRefreshHttp


+ (void)httpStart:(void (^ __nullable)(void))start Success:(void (^ __nullable)(void))success failed:(void (^ __nullable)(NSString *msssage))failed finish:(void (^ __nullable)(void))finish{
     start();
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    paramesAddDictionary(parames);
    
    NSString *loginName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    NSString *loginPwd =  [[NSUserDefaults standardUserDefaults] objectForKey:USER_PWDS];
    
    
    if([[loginName trim] isEqualToString:@""] || [[loginPwd trim] isEqualToString:@""]){
        finish();
        failed(@"loaginName or loginPassword is NULL");
        return;
    }
    
    [parames setObject:loginName forKey:@"loginName"];
    [parames setObject:loginPwd forKey:@"userPwd"];
    
    [session POST:url_login parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[STools dictJsonString: responseObject]);
              finish();
              if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                  NSDictionary *result = [responseObject objectForKey:@"result"];
                  // 保存用户信息（ 静态数据保存 ）
                  [DataManage share].userModel = [UserModel userWithDic:result];
                  success();
              }else{
                  failed(nil);
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               finish();
              failed(error.domain);
              
          }];
    }

@end
