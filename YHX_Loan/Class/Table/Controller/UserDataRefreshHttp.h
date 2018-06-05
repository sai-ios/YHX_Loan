//
//  UserDataRefreshHttp.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/6/1.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataRefreshHttp : NSObject
+ (void)httpStart:(void (^ __nullable)(void))start Success:(void (^ __nullable)(void))success failed:(void (^ __nullable)(NSString *msssage))failed finish:(void (^ __nullable)(void))finish;
@end
