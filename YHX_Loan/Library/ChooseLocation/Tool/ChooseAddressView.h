//
//  ChooseAddressView.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/22.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"
#import <objc/runtime.h>

@interface ChooseAddressView : UIView

@property (nonatomic,strong) ChooseLocationView *chooseLocationView;

//+(instancetype)addressInit:(id<UIGestureRecognizerDelegate>)delegate;
+(instancetype)addressInit;
-(void)show:(void (^ __nullable)(NSString* address))handler;


@end
