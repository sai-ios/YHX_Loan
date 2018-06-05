//
//  RepayPlanTableController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/9.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "RepayPlanTableController.h"
#import "repayPlanTableCell.h"
#import "RepaymentHistoryViewController.h"
#import "EarlyRepaymentController.h"
#import "ChanageRepayBankNumberController.h"
#import "XYRepayPlan.h"
@interface RepayPlanTableController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *loanAllMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *loanBankNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanageNumberBt;
@property (weak, nonatomic) IBOutlet UIButton *earlyRepaymentBtn;
@property (weak, nonatomic) IBOutlet UILabel *loanCount;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewBg;
//
@property(nonatomic, strong) NSArray<XYRepayPlan*> *repayPlanArray;

@end

@implementation RepayPlanTableController

#pragma mark -PlanDataArray加载
-(void)loadPlanDataArray:(NSArray<XYRepayPlan*>*)array{
    
    _repayPlanArray = [XYRepayPlan repayPlanArrayWithDic:array];
    [self.tableView reloadData];
    if([_repayPlanArray count]>0)
    [self setHeadData];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款计划";
    [self setBgView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _repayPlanArray = [NSArray array];
    
    // 设置是否能查看还款记录与修改还款账号及还款
    [self setLoanRepayPlan];
    //设置下来刷新功能
    [self.tableView bindRefreshStyle:KafkaRefreshStyleAnimatableRing
                           fillColor:XZRGB(0xffFB8557)
                          atPosition:KafkaRefreshPositionHeader refreshHanler:^{
                              [self HTTPServer];
                          }];
    [self.tableView.headRefreshControl beginRefreshing];
  
}

#pragma mark -View init
// 设置头部信息
-(void)setHeadData{
    
}


// 设置是否能查看还款记录与修改还款账号及还款
-(void)setLoanRepayPlan{
    
    //如果是兴业贷款 添加右边还款记录按键
    UIBarButtonItem *historyRepayItem = [[UIBarButtonItem alloc]initWithTitle:@"还款记录" style:UIBarButtonItemStylePlain target:self action:@selector(repayHistoryClick)];
    self.navigationItem.rightBarButtonItem = historyRepayItem;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)setBgView {
    _earlyRepaymentBtn.layer.shadowColor = [UIColor grayColor].CGColor;//阴影颜色
    _earlyRepaymentBtn.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    _earlyRepaymentBtn.layer.shadowOpacity = 0.5;//透明度
    _earlyRepaymentBtn.layer.shadowRadius = 5.0;//半径
    _earlyRepaymentBtn.layer.cornerRadius = 20.0;
    
    //背景图片设置
    UIImage *image = [UIImage imageNamed:@"home_bg.png"];
    self.viewBg.layer.contents = (id) image.CGImage;
    self.viewBg.layer.backgroundColor = [UIColor clearColor].CGColor;
    
}
#pragma mark -onClickListenter
/**
 * 点击事件处理
 */
- (IBAction)onViewClicked:(id)sender {
    if(sender == _earlyRepaymentBtn){
        EarlyRepaymentController *earlyVc = [[EarlyRepaymentController alloc]init];
        earlyVc.loan = self.loan;
        [self.navigationController pushViewController:earlyVc animated:YES];
    }
    
}

/**
 * 还款历史记录
 */
- (void)repayHistoryClick{
    RepaymentHistoryViewController *repayHistoryVc = [[RepaymentHistoryViewController alloc]init];
    repayHistoryVc.loan = self.loan;
    [self.navigationController pushViewController:repayHistoryVc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 *  修改还款银行卡
 */
- (IBAction)modifyRepayNumber:(id)sender {
    ChanageRepayBankNumberController *chanageVc = [[ChanageRepayBankNumberController alloc]init];
    chanageVc.loan = self.loan;
    [self.navigationController pushViewController:chanageVc animated:YES];
    
}



#pragma mark -网络请求
-(void)HTTPServer{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    paramesAddDictionary(parames);
    [parames setObject:_loan.customerCode  forKey:@"customerCode"];
    [parames setObject:[DataManage share].userModel.idCardNumber  forKey:@"customerCardNo"];
    [parames setObject:_loan.transSeq  forKey:@"chnseq"];
    NSLog(@"请求数据-->%@",[STools dictJsonString: parames]);
    
    [EasyShowLodingView showLodingText:@"加载中"];
    
    [session POST:url_queryRepayList parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[STools dictJsonString: responseObject]);
               [EasyShowLodingView hidenLoding];  // 关闭HUD
               [self.tableView.headRefreshControl endRefreshing];
              if([@"000000" isEqualToString:[responseObject objectForKey:@"respCode"]]){
                  @try {
                      NSArray *array = [responseObject objectForKey:@"result"];
                      [self loadPlanDataArray:array];
                  }
                  @catch (NSException *exception) {
                      NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
                  }
                 
                
              }else{
                  [EasyShowTextView showText:@"加载失败!"];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [self.tableView.headRefreshControl endRefreshing];
              [EasyShowTextView showText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];
}

#pragma mark -tableView 代理、数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.repayPlanArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =  indexPath.row;//:表示当前是第几行
    repayPlanTableCell *cell = [repayPlanTableCell repayCellWithTableView:tableView];
    [cell setRepayPlanData:self.repayPlanArray[row]];
    [cell setcellForRowAtIndexPath:indexPath table:tableView];
    return cell;
}


@end
