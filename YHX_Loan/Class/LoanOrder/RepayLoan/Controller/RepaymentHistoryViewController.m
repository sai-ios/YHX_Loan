//
//  RepaymentHistoryViewController.m
//  YHX_Loan
//  还款记录
//  Created by 张磊 on 2018/5/10.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "RepaymentHistoryViewController.h"
#import "RepayHistoryCell.h"
@interface RepaymentHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// Data
@property(nonatomic, strong) NSMutableArray<RepayHistory*> *historyArray;
@end

@implementation RepaymentHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款记录";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    _historyArray = [NSMutableArray array];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataInit:(NSArray*)array{
    _historyArray = [NSMutableArray array];
    for (NSDictionary *object in array) {
        if(object!=nil){
            RepayHistory *history = [RepayHistory historyWithDic:object];
            [_historyArray addObject:history];
        }
    }
    [self.tableView reloadData];
}


#pragma mark -数据加载
-(void)HttpRequesthistory{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    paramesAddDictionary(parames);
    [parames setObject:_loan.busCode  forKey:@"busCode"];
    
    NSLog(@"请求数据-->%@",[STools dictJsonString: parames]);
    
    [EasyShowLodingView showLodingText:@"加载中"];
    
    [session POST:url_queryRepayList parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[STools dictJsonString: responseObject]);
              [EasyShowLodingView hidenLoding];  // 关闭HUD
              if([responseObject[@"respCode"]isEqualToString:@"000000"]){
                  NSArray *result = [responseObject objectForKey:@"result"];
                  [self dataInit:result];
              }else{
                [EasyShowTextView showErrorText:@"加载失败!"];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showErrorText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];
}


#pragma mark -tableView数据源方法
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RepayHistoryCell *cell = [RepayHistoryCell historyCellWithtableView:tableView];
    [cell setHistoryData: _historyArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_historyArray count];
}


@end
