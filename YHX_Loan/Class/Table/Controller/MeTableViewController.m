//
//  MeTableViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/23.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "MeTableViewController.h"
#import "UserModel.h"
#import "SPLoginViewController.h"
#import "LoanTableController.h"
#import "NSWebViewController.h"
#import "UserDataRefreshHttp.h"
@interface MeTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameText;
@property (weak, nonatomic) IBOutlet UILabel *phoneText;
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UITableViewCell *authCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *bankCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *loanCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *messageCell;


@end

@implementation MeTableViewController

/**
 * 设置圆形头像 View
 */
- (void) circleOldImage{
    _userIcon.layer.masksToBounds = YES;
    //图片自身宽度除以2可设置为圆形
    _userIcon.layer.cornerRadius = _userIcon.bounds.size.width/2.0;
    //边框
    [_userIcon.layer setBorderWidth:2];
    _userIcon.layer.borderColor = ALRGB(0xffffffff,0.6).CGColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeadBgView];
    [self setbackItem];
    [self circleOldImage];
    
}

-(void)UserDataRefreshHttp{
    [UserDataRefreshHttp httpStart:^{
    } Success:^{
        [self addUserData];
       } failed:^(NSString *msssage) {
           [EasyShowTextView showText:@"数据刷新失败"];
    } finish:^{
        [self.tableView.headRefreshControl endRefreshing];
    }];
}

-(void)addUserData{
    // 开始更新
    [self.tableView beginUpdates];
    _phoneText.text = @"";
    UserModel *user = [DataManage share].userModel;
    if(user != nil){
       if(user.realNameState == YES){
           NSString *realName = user.realName;
           // 显示用户名
           _userNameText.text = realName;
           _phoneText.text =[STools hidetel:user.loginName];
           if(!user.basicInfoState || !user.workState){
               _authCell.detailTextLabel.text = @"未完成";
           }else if(user.basicInfoState && user.workState){
               _authCell.detailTextLabel.text = @"认证完成";
           }
           _bankCell.detailTextLabel.text = [NSString stringWithFormat:@"%ld张", user.bankBindState];
          
       }else{
            _userNameText.text = user.loginName;
            _phoneText.text = @"";
            _authCell.detailTextLabel.text = @"未认证";
        }
    }else{
        _userNameText.text = @"请登录";
        _authCell.detailTextLabel.text = @"";
        _bankCell.detailTextLabel.text = @"";
    }
    // 结束更新
     [self.tableView endUpdates];
   
}

// 加载头部View
- (void)addHeadBgView{
    // 解决iOS 11状态栏沉浸失效的问题
    if (@available(iOS 11.0, *)) {
        _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        UIEdgeInsets insets = UIEdgeInsetsMake(0,0.0,0,0.0);
        _table.contentInset = insets;
    }
    // 改变tableView header高度
    CGFloat height = [_headBgView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = _headBgView.bounds;
    frame.size.height = height+ [SPToolBox statueHeight] + 150;
    _headBgView.frame = frame;
    [_table setTableHeaderView:self.headBgView];
    // 添加背景图片
    UIImage *image = [UIImage imageNamed:@"home_bg.png"];
    self.tableView.tableHeaderView.layer.contents = (id) image.CGImage;
    // 设置填充模式
    [self.tableView.tableHeaderView setContentMode:UIViewContentModeScaleAspectFill];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self addUserData];
    if([DataManage share].userModel != nil){
        
        NSData *icon = [[NSUserDefaults standardUserDefaults] objectForKey:[DataManage share].userModel.loginName];
        if(icon != nil){
            UIImage *circleImage = [UIImage imageWithData:icon];
                [_userIcon setImage:circleImage];
           
        }
        
        [self.tableView bindRefreshStyle:KafkaRefreshStyleAnimatableRing
                               fillColor:XZRGB(0xffFB8557)
                              atPosition:KafkaRefreshPositionHeader refreshHanler:^{
                                  [self UserDataRefreshHttp];
                              }];
    }
   
}

-(void)pushViewController:(UIViewController *)viewController{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)setbackItem{
    
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"home_icon_back.png"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"home_icon_back.png"]];
    // 设置返回键内容
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark 点击事件
- (IBAction)headViewClick:(id)sender {
    if([_userNameText.text isEqualToString:@"请登录"]){
        SPLoginViewController *loginVc = [[SPLoginViewController alloc]init];
        [self pushViewController:loginVc];
    }
}


#pragma mark - Table view data source
//设置分组间的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 5;
}

// 选择判断
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld --- %ld",indexPath.section,indexPath.row);
     if(indexPath.section == 0 ){
        if( [DataManage share].userModel == nil){
            SPLoginViewController *loginVc = [[SPLoginViewController alloc]init];
            [self pushViewController:loginVc];
            return;
        }
         switch (indexPath.row) {
             case 0:
                  [self performSegueWithIdentifier:@"identifler_usertable" sender:nil];
                 break;
             case 1:
                 //没有实名的先实名操作
                 if([DataManage share].userModel.realNameState == YES){
                     [self performSegueWithIdentifier:@"identifler_bank" sender:nil];
                 }else{
                     [EasyShowTextView showInfoText:@"请先实名操作"];
                 }
                 break;
             case 2:
                 [self performSegueWithIdentifier:@"identifler_loanls" sender:nil];
                 break;
             default:
                 break;
         }
  
     }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            if( [DataManage share].userModel == nil){
                SPLoginViewController *loginVc = [[SPLoginViewController alloc]init];
                [self pushViewController:loginVc];
                return;
            }
            [self performSegueWithIdentifier:@"identifler_message" sender:nil];
        }
    }  
}


@end
