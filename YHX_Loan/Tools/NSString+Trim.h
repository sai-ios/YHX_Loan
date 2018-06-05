//
//  NSString+Trim.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/16.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)
//去除首尾空格和换行
-(NSString *)trim;
//. 去除首尾空格
-(NSString *)trimSpace;
//1. 去除首尾换行
-(NSString *)trimEnter;


@end
