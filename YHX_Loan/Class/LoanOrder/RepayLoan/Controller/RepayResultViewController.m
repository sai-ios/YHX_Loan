//
//  RepayResultViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/10.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "RepayResultViewController.h"
#import "RepayPlanTableController.h"
@interface RepayResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *resultImage;
@property (weak, nonatomic) IBOutlet UILabel *resultTitleText;
@property (weak, nonatomic) IBOutlet UILabel *resultTipLable;

@end

@implementation RepayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 更改导航返回键返回事件
    self.title =@"还款申请";
    [self setBackButtonTarget:self action:@selector(clickbackButton)];
}

- (IBAction)backBtOnClick:(id)sender {
    [self clickbackButton];
}

- (void)clickbackButton{
    [self popToViewControllerOfClass:[RepayPlanTableController class] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
