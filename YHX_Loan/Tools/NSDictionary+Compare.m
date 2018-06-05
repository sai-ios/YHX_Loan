//
//  NSDictionary+Compare.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/15.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "NSDictionary+Compare.h"

@implementation NSDictionary (Compare)

- (NSArray *)nk_ascendingComparedAllKeys
{
    NSArray *allKeys = [self keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] < [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return allKeys;
}


- (NSArray *)nk_descendingComparedAllKeys
{
    NSArray *allKeys = [self keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] < [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return allKeys;
}
@end
