//
//  SNBaseViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/8.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "SNBaseViewController.h"
#import "PersonTableViewController.h"
@interface SNBaseViewController ()

@end

@implementation SNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"home_icon_back.png"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"home_icon_back.png"]];
    // 设置返回键内容
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
       [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];

}

- (void)setBackButtonTarget:(nullable id)target action:(SEL)action {
    // 更改导航返回键返回事件
    UIImage *backImage = [UIImage imageNamed:@"home_icon_back.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:backImage forState:UIControlStateNormal];
    [button setTitle:@"返回"   forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void)popToViewControllerOfClass:(Class)aClass animated:(BOOL)animated{
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:aClass]) {
            [self.navigationController popToViewController:temp animated:animated];
        }
    }
}

// 长度大于0 且不等于默认值返回true
-(BOOL)checkButtonEmpty:(UIButton *)button default:(NSString*)text{
    NSString *string = [button.titleLabel.text trim];
    return ![string isEqualToString:text] && string.length > 0;
}

-(BOOL)checkLabelEmpty:(UILabel *)lable;
{
    NSString *string = [lable.text trim];
    return string.length > 0;
}
-(BOOL)checkFieldEmpty:(UITextField *)field{
    NSString *string = [field.text trim];
    return string.length > 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark ShowAlert
-(void)showAlertList:(ShowAlertTitleType)dictTitleType title:(NSString *)title dataDict:(NSDictionary *)data black:(void (^ __nullable)(NSString *key ,NSString *value))handler{
    // cancel button
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@">>> Click the cancel button.");
    }];
    [alertController addAction:cancelAction];
    for (NSString *key in data) {
        if(dictTitleType == dictKeyInTitle){
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:key style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //把选择的内容返回给调用者
                handler(key,data[key]);
                }];
           [alertController addAction:otherAction];
        }
        else if(dictTitleType == dictValueInTitle){
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:data[key] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //把选择的内容返回给调用者
                handler(key,data[key]);
            }];
            [alertController addAction:otherAction];
        }
    }
    
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark navigationController 中使用的提示框
-(void)showAlertHint:(NSString *)title message:(NSString *)data buttonTitle:(NSString*)btntitle handler:(void (^ __nullable)(UIAlertAction *action))handler{
    // cancel button
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:data preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:btntitle style:UIAlertActionStyleCancel handler:handler];
    [alertController addAction:cancelAction];
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];
   
}

@end
