//
//  ChooseLocationController.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/22.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseLocationController : UIViewController

//声明一个block 回传地址
@property(copy)void(^block)(NSString* address,NSString* areaCode);


@end
