//
//  LoanTableController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/23.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanTableController.h"
#import "GetLoanListServer.h"
#import "LoanListTableViewCell.h"
#import "LoanDetailsViewController.h"
@interface LoanTableController ()

@property(nonatomic, strong) NSArray *loanArray;

@property(nonatomic, assign) BOOL ref;
@end

@implementation LoanTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    _ref = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([DataManage share].userModel != nil){
        [self.tableView bindRefreshStyle:KafkaRefreshStyleAnimatableRing
                               fillColor:XZRGB(0xffFB8557)
                              atPosition:KafkaRefreshPositionHeader refreshHanler:^{
             [GetLoanListServer getLoanListsuccess:^(NSArray *loanList) {
                 [self.tableView.headRefreshControl endRefreshing];
                 self.loanArray = loanList;
                 [self.tableView reloadData];
             
             } failed:^(NSString *msssage) {
                 [self.tableView.headRefreshControl endRefreshing];
             }];
                              }];
        if(_ref){ // 只自动刷新一次
            [self.tableView.headRefreshControl beginRefreshing];
            _ref = NO;
        }
    }
}

-(void)setBackView{
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"home_icon_back.png"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"home_icon_back.png"]];
    // 设置返回键内容
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)showAlertHint:(NSString *)title message:(NSString *)data buttonTitle:(NSString*)btntitle handler:(void (^ __nullable)(UIAlertAction *action))handler{
    // cancel button
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:data preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:btntitle style:UIAlertActionStyleCancel handler:handler];
    [alertController addAction:cancelAction];
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoanDetailsViewController *loanDetailVc = [[LoanDetailsViewController alloc]init];
    loanDetailVc.loanBasicInfo = self.loanArray[indexPath.row];
    [self pushViewController:loanDetailVc];
    
}

// 每组显示几条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.loanArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row =  indexPath.row;//:表示当前是第几行
    LoanListTableViewCell *cell = [LoanListTableViewCell loanListCellWithTableView:tableView];
    [cell setCellLoanInfo:self.loanArray[row]];
    return cell;
}

@end
