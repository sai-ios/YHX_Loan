//
//  NSString+Trim.m
//  YHX_Loan
//
//  Created by niusaibing on 2018/5/16.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)
- (NSString *)trim{
    if(self == nil)
        return @"";
  return   [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimSpace{
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimEnter{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}
@end
