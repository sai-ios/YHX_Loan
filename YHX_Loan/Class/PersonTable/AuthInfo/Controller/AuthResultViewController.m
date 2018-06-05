//
//  AuthResultViewController.m
//  YHX_Loan  展示 银行卡绑定成功、失败；实名认证结果，贷款结果显示。
//  icon IDcard 验证结果显示 icon_submit_success@3x.png
//
//
//
//
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "AuthResultViewController.h"
#import "PersonTableViewController.h"
@interface AuthResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *resultImage;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation AuthResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"提交结果";
    [_finishBtn setTitle:@"认证成功点击返回" forState:UIControlStateNormal];
    
    // 更改导航返回键返回事件
   [self setBackButtonTarget:self action:@selector(clickbackButton)];

}

- (void)clickbackButton{
    [self popToViewControllerOfClass:[PersonTableViewController class] animated:YES];
}


// 确认键点击事件响应
- (IBAction)finishBtnOnClick:(id)sender {
    [self clickbackButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
