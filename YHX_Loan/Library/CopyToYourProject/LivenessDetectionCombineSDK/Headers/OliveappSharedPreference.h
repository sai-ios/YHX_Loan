//
//  sharedPreference.h
//  LivenessDetector
//
//  Created by Xiaoyang Lin on 16/4/19.
//  Copyright © 2016年 Oliveapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OliveappSharedPreference : NSObject


@property BOOL isDebug;//是否是Debug模式
@property (strong, nonatomic) NSString * mSessionName;
/**
 *  单例
 *
 *  @return <#return value description#>
 */
+ (instancetype) sharedPreference;

@end
