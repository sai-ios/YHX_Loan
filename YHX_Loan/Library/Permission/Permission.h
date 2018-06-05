//
//  Permission.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import <Contacts/Contacts.h>
@interface Permission : NSObject
+(BOOL)isCanUsePhotos;

+(BOOL)JudgeCameraPermission;

+(BOOL)JudgeLocationPermission;
+(void)CanOpenURLToSetting:(void (^ __nullable)(BOOL success))completion;
@end
