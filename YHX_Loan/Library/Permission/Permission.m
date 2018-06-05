//
//  Permission.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "Permission.h"

@implementation Permission

+(BOOL)isCanUsePhotos {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    return YES;
}




+(BOOL)JudgeCameraPermission{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied||![self isCanUsePhotos])
    {
        return NO;
    }
    return YES;
}

+(BOOL)JudgeLocationPermission{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        return YES;
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        return NO;
    }
    return NO;
}

+(void)CanOpenURLToSetting:(void (^ __nullable)(BOOL success))completion{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        
        NSString *version = [UIDevice currentDevice].systemVersion;
        if([version doubleValue]>=10.0){
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                completion(success);
            }];
        }else{
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}



@end
