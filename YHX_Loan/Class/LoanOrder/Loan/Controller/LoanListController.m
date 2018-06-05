//
//  LoanListController.m
//  YHX_Loan
//  展示贷款记录列表
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "LoanListController.h"
#import "GetLoanListServer.h"
#import "LoanListTableViewCell.h"
@interface LoanListController ()
@property(nonatomic, strong) NSArray *loanArray;
@end

@implementation LoanListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
