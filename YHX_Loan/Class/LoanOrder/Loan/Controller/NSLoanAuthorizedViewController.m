//
//  NSLoanAuthorizedViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/9.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "NSLoanAuthorizedViewController.h"

@interface NSLoanAuthorizedViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultMessageLabel;

@end

@implementation NSLoanAuthorizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"申请提交结果";
    _resultMessageLabel.text = @"申请已提交成功，耐心等待审核结果\n请点击返回";
    [self setBackButtonTarget:self action:@selector(popRootVcCilck:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)popRootVcCilck:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
