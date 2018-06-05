//
//  GetLoanListServer.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetLoanListServer : NSObject

+(instancetype)shareInstance;

+(void)getLoanListsuccess:(void (^ __nullable)(NSArray *loanList))success failed:(void (^ __nullable)(NSString *msssage))failed;
@end
