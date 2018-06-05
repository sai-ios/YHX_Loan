//
//  HttpAddParameters.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/17.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "HttpAddParameters.h"

@implementation HttpAddParameters

+ (void)addFixedValueWithDic:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeStr = [timeFormatter stringFromDate:[NSDate date]];
    
    NSString *udidStr = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    [sender setObject:@"iOS" forKey:@"sysType"]; //iOS
    [sender setObject:[[UIDevice currentDevice] systemVersion] forKey:@"sysVer"];//系统版本
    [sender setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVer"];//APP版本
    [sender setObject:udidStr forKey:@"deviceId"];//设备uuid
    [sender setObject:dateStr forKey:@"txnDate"];
    [sender setObject:timeStr forKey:@"txnTime"];
    
    NSString *loginName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    if(loginName!=nil)
       [sender setObject:loginName forKey:@"loginName"];
}

@end
