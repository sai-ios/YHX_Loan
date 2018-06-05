//
//  SettingViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "SettingViewController.h"
#import "SPLoginViewController.h"
#import "ChangePwdViewController.h"
#import "AboutUsViewController.h"
#import "QuestionsController.h"
@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loginNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImage;
@property (weak, nonatomic) IBOutlet UIButton *loginOutBt;
@property (weak, nonatomic) IBOutlet UITableViewCell *pwdCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *versionCell;

@end

@implementation SettingViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView beginUpdates];
    // 版本
    _versionCell.detailTextLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if([DataManage share].userModel != nil){
        [_loginOutBt setTitle:@"安全退出" forState:UIControlStateNormal];
        if([DataManage share].userModel.realNameState == YES){
            NSString *realName = [DataManage share].userModel.realName;
            // 显示实名
            _loginNameLabel.text = realName;
        }else{
            // 为实名认证 显示登录名（手机号）
            _loginNameLabel.text = [STools hidetel:[DataManage share].userModel.loginName];
        }
        _pwdCell.detailTextLabel.text = @"修改密码";
    
        NSData *icon = [[NSUserDefaults standardUserDefaults] objectForKey:[DataManage share].userModel.loginName];
        if(icon != nil){
            [_userIconImage setImage:[UIImage imageWithData:icon]];
        }
     
    }else{
        _loginNameLabel.text  = @"用户名";
        [_loginOutBt setTitle:@"登录" forState:UIControlStateNormal];
        _pwdCell.detailTextLabel.text = @"";
    }
     [self.tableView endUpdates];
}

/**
 * 设置圆形头像 View
 */
- (void) circleOldImage{
    _userIconImage.layer.masksToBounds = YES;
    //图片自身宽度除以2可设置为圆形
    _userIconImage.layer.cornerRadius = _userIconImage.bounds.size.width/2.0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self circleOldImage];
    
}

// 头像选择 ，设置
- (IBAction)changeIconClick:(id)sender {
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc]init];
    actionSheet.configuration.allowSelectGif = NO;
    actionSheet.configuration.allowSelectVideo = NO;
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = NO;
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = 1;
    //单选模式是否显示选择按钮
    actionSheet.configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
    actionSheet.configuration.editAfterSelectThumbnailImage = YES;
    //是否保存编辑后的图片
    actionSheet.configuration.saveNewImageAfterEdit = NO;
    //颜色，状态栏样式
        actionSheet.configuration.selectedMaskColor = [UIColor whiteColor];
        actionSheet.configuration.navBarColor = [UIColor whiteColor];
        actionSheet.configuration.navTitleColor = [UIColor blackColor];
        actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
        actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
        actionSheet.configuration.bottomViewBgColor = [UIColor darkTextColor];
        actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    actionSheet.configuration.shouldAnialysisAsset = YES;
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = self;
    __weak typeof(self) weakSelf = self;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        if([images count]>0){
            [weakSelf.userIconImage setImage:images[0]];
            NSLog(@"image:%@", images);
            [self saveUserIconToNSUserDefaults:images[0]];
        }
       
       
    }];
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    // 选择相册
    [actionSheet showPhotoLibrary];
}

- (IBAction)quitLogin:(id)sender {
     if([DataManage share].userModel != nil){
    // 跳转到登录界面
    // cancel button
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { }];
        
         [alertController addAction:cancelAction];
         UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             // 清除用户数据
             [DataManage share].userModel = nil;
             [self pushLoginViewController];
        
        }];
         [alertController addAction:yesAction];
         //show alert controller
         [self presentViewController:alertController animated:YES completion:nil];
     }else{
         [self pushLoginViewController];
     }
   
}

-(void)pushLoginViewController{
    SPLoginViewController *loginVc = [[SPLoginViewController alloc]init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


-(void)setBackView{
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"home_icon_back.png"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"home_icon_back.png"]];
    // 设置返回键内容
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
}



#pragma mark 代理方法 选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%ld",indexPath.row);
    
    // 修改登录密码 0
    if(indexPath.row == 0){
        if([DataManage share].userModel != nil){
            ChangePwdViewController *modifyVc = [[ChangePwdViewController alloc]init];
            [self.navigationController pushViewController:modifyVc animated:YES];
        }
    }
    // 联系客服 1
    else if (indexPath.row == 1){
        
    }
    // 当前版本 2
    else if (indexPath.row == 2){
        
    }
    // 关于我们 3
    else if (indexPath.row == 3){
        AboutUsViewController *aboutVc = [[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutVc animated:YES];
    }
    // 建议反馈 4
    else if (indexPath.row == 4){
        QuestionsController *questionVC = [[QuestionsController alloc]init];
        [self.navigationController pushViewController:questionVC animated:YES];
    }
  
}

-(void)saveUserIconToNSUserDefaults:(UIImage*)image
{
    NSData *data = [STools compressImage:image toByte:800*1024*1024];
    
    if([DataManage share].userModel != nil){
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:[DataManage share].userModel.loginName];
    [[NSUserDefaults standardUserDefaults]synchronize];//同步、保存
    }
}


@end
