//
//  DataManage.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/21.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface DataManage : NSObject

// user
@property(nonatomic, strong) UserModel *userModel;

+ (instancetype)share;

@end
