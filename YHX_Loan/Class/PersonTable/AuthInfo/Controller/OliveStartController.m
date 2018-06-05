//
//  OliveStartController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "OliveStartController.h"
#import "OliveappLivenessDetectionViewController.h"
#import "OliveappLivenessDataType.h"
#import "OliveappBase64Helper.h"

#import "OliveStartController.h"
#import "RealNameController.h"
#import "OliveappLivenessDetectionViewController.h"
#import "OliveappLivenessDataType.h"
#import "OliveappBase64Helper.h"
#import "Permission.h"
@interface OliveStartController ()<OliveappLivenessResultDelegate>

@end

@implementation OliveStartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脸识别";
    
}

//开始进行人脸识别
- (IBAction)startOliveClick:(id)sender {
    // 模拟器跳过人脸识别进行测试数据演示效果
//    RealNameController *amortVC = [[RealNameController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:amortVC animated:YES];
    //人脸识别智能进行真机测试
    // 申请权限操作
    if([Permission JudgeCameraPermission]){
          [self startLivenessDetection];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"缺少权限" message:@"没有打开相机的权限，App不能正常使用！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [Permission CanOpenURLToSetting:^(BOOL success) {
                NSLog(@">>> Permission the CanOpenURLToSetting is %@",success?@"YES":@"NO");
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@">>> Click the cancel button.");
        }];
        [alertController addAction:yesAction];
        [alertController addAction:cancelAction];
        //show alert controller
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -活体检测 -- 开始

- (void)startLivenessDetection
{
    // 获取活体检测的storyboard和viewcontroller对象
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"LivenessDetection" bundle: nil];



     // 对于iPad，活体检测有两种布局，竖屏和横屏。综合防hack,通过率和体验，强力推荐使用竖屏布局！

    OliveappLivenessDetectionViewController* livenessViewController = (OliveappLivenessDetectionViewController*) [board instantiateViewControllerWithIdentifier: @"LivenessDetectionStoryboard"];

    // 横屏布局的界面，如果要使用的话，请使用下面代码
    //    OliveappLivenessDetectionViewController* livenessViewController = (OliveappLivenessDetectionViewController*) [board instantiateViewControllerWithIdentifier: @"LivenessDetectionLandscapeStoryboard"];

    //以下样例代码展示了如何初始化活体检测
    __weak typeof(self) weakSelf = self;
    NSError *error;
    BOOL isSuccess;

    //Mode有两种模式，默认第二种，体验更好
    // INSTANT_CHANGE,活体检测动作成功后不等语音播放完就进入下一个动作
    // FLUENT_CHANGE,活体检测动作成功后会等语音播放完才进入下一个动作
    isSuccess = [livenessViewController setConfigLivenessDetection: weakSelf
                                                          withMode: FLUENT_CHANGE
                                                         withError: &error];
    //弹出活体检测界面，可用show,push
    [self presentViewController:livenessViewController animated:YES completion:nil];
}

#pragma mark -活体检测 -- 回调函数
/**
 *  活体检测成功的回调
 *
 *  @param detectedFrame 返回检测到的图像
 */

- (void) onLivenessSuccess: (OliveappDetectedFrame*)detectedFrame {

    //detectedFrame中有4个用于比对的数据包，具体使用哪个数据包进行比对请咨询对接工作人员
    //对数据包进行Base64编码的方法，用户发送Http请求,下面以带翻拍的数据包为样例

    [self dismissViewControllerAnimated:YES completion:^{

        [EasyShowTextView showSuccessText:@"人脸识别成功!"];

        RealNameController *amortVC = [[RealNameController alloc] initWithNibName:nil bundle:nil];
        amortVC.hidesBottomBarWhenPushed = YES;
        amortVC.verificationData = [OliveappBase64Helper encode:detectedFrame.verificationDataFullWithFanpai];
        [self.navigationController pushViewController:amortVC animated:YES];
        //移除 当前界面
        [self removeOnliveness];

    }];
}

/**
 *  活体检测失败的回调
 *
 *  @param sessionState  活体检测的返回状态
 *  @param detectedFrame 返回检测到的图像
 */
- (void) onLivenessFail: (int)sessionState withDetectedFrame: (OliveappDetectedFrame*)detectedFrame {
    NSLog(@"活体检测失败");
// 人脸识别检测失败 ，请重新进行人脸识别
    __weak typeof(self) weakSelf = self;

    [self dismissViewControllerAnimated:YES completion:^{
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"人脸识别检测失败,请重新进行人脸识别" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             NSLog(@"取消操作");
         }];
         UIAlertAction *entAction = [UIAlertAction actionWithTitle:@"重新操作" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             NSLog(@"重新操作");
             [weakSelf startLivenessDetection];
         }];
         [alertController addAction:cancelAction];
         [alertController addAction:entAction];
         [weakSelf presentViewController:alertController animated:true completion:nil];
    }];
}

/**
 *  移除检测提示界面
 */
-(void)removeOnliveness{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[OliveStartController class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}

/**
 *  取消按钮的操作方法
 */
- (void) onLivenessCancel {
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
