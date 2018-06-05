//
//  SNBaseViewController.h
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/8.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowAlertTitleType) {
    dictKeyInTitle = 0,
    dictValueInTitle
};

@interface SNBaseViewController : UIViewController

-(BOOL)checkButtonEmpty:(UIButton *)button default:(NSString*)text;
-(BOOL)checkLabelEmpty:(UILabel *)lable;
-(BOOL)checkFieldEmpty:(UITextField *)field;
- (void)setBackButtonTarget:(nullable id)target action:(SEL)action;
-(void)popToViewControllerOfClass:(Class)aClass animated:(BOOL)animated;

-(void)showAlertList:(ShowAlertTitleType)dictTitleType title:(NSString *)title dataDict:(NSDictionary *)data black:(void (^ __nullable)(NSString *key ,NSString *value))handler;
-(void)showAlertHint:(NSString *)title message:(NSString *)data buttonTitle:(NSString*)btntitle handler:(void (^ __nullable)(UIAlertAction *action))handler;
@end
