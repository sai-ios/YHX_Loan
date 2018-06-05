//
//  LoanAuthViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/27.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanAuthViewController.h"
#import "LoanContactViewController.h"
@interface LoanAuthViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *loadLabel;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UIButton *knowBt;
@property (weak, nonatomic) IBOutlet UIStackView *loadingStackView;

@end

@implementation LoanAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小额贷";
    
    _knowBt.userInteractionEnabled = NO;
    [_tipView setAlpha:0.0f];
    [_loadingView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(5*NSEC_PER_SEC)),
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [self.loadingView stopAnimating];
                           [self.loadingStackView setAlpha:0.f];
                           [_tipView setAlpha:1.0f];
                           _knowBt.userInteractionEnabled = YES;
                       });
                      
                   });
}
- (IBAction)nextLoanClick:(id)sender {
    
    LoanContactViewController *contactVc = [[LoanContactViewController alloc]init];
    [self.navigationController pushViewController:contactVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
