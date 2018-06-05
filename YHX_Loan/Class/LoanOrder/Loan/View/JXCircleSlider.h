//
//  JXCircleSlider.h
//  JXCircleSlider
//
//  Created by JackXu on 15/6/23.
//  Copyright (c) 2018年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCircleSlider : UIControl
@property (nonatomic,assign) int lineWidth;
@property (nonatomic,setter=changeAngle:) int angle;
@property (nonatomic,assign) int multiple;
@end
