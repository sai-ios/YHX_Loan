//
//  NSDictionary+Compare.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/15.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Compare)
/*****************获取升序键值*********************/
- (NSArray *)nk_ascendingComparedAllKeys;

/*****************获取降序键值*********************/
- (NSArray *)nk_descendingComparedAllKeys;
@end
