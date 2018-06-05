//
//  RealNameController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "RealNameController.h"
#import "AuthResultViewController.h"
#import "ChooseLocationController.h"

#import <AipOcrSdk/AipOcrSdk.h>
#import "ORCIDCardModel.h"
#import "STools.h"
#import "NSData+MKBase64.h"
#import "DateUtils.h"
#define HEADS 1
#define TAILS 2
#define byteLength 400000
@interface RealNameController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *HeadsImage;
@property (weak, nonatomic) IBOutlet UIImageView *tailsImage;
@property (weak, nonatomic) IBOutlet UITextField *realNameField;
@property (weak, nonatomic) IBOutlet UITextField *sexField;
@property (weak, nonatomic) IBOutlet UITextField *ethincField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *signEndDateField;
@property (weak, nonatomic) IBOutlet UIButton *regAdreeBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;

// 身份证数据
@property(nonatomic, strong) ORCIDCardModel *idCardModel;
// 图片类型
@property(nonatomic, assign) int photoType;
// 图片路径
@property(nonatomic, strong) NSString *frontPicPath;
@property(nonatomic, strong) NSString *backPicPath;
// 是否完成操作
@property(nonatomic, assign) BOOL headsBool;
@property(nonatomic, assign) BOOL tailsBool;

// 有效期开始
@property(nonatomic, strong) NSString *signdate;
// 有效期结束
@property(nonatomic, strong) NSString *expirydate;

@end

@implementation RealNameController{
    // 默认的识别成功的回调
    void (^successHandler)(id);
    // 默认的识别失败的回调
    void (^failHandler)(NSError *);

}

- (void)loadORC{
 //     授权方法1：在此处填写App的Api Key/Secret Key
    [[AipOcrService shardService] authWithAK:@"Q7OCa8Uq2fkFD3iZ4PcTiNL7" andSK:@"t1gUPDuwiXKwkb1U9gdO4njB9hvx1yFg"];
    // 授权方法2（更安全）： 下载授权文件，添加至资源
//    NSString *licenseFile = [[NSBundle mainBundle] pathForResource:@"aip" ofType:@"license"];
//    NSData *licenseFileData = [NSData dataWithContentsOfFile:licenseFile];
//    if(!licenseFileData) {
//        [[[UIAlertView alloc] initWithTitle:@"授权失败" message:@"授权文件不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//    }
//    [[AipOcrService shardService] authWithLicenseFileData:licenseFileData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活体信息认证";
    [self loadORC];
    [self configCallback];
    NSLog(@"oliveBase64 %@",self.verificationData);
    self.idCardModel = [[ORCIDCardModel alloc]init];
    //初始化数据
    _photoType = 0;
    _headsBool = false;
    _tailsBool = false;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)upbuttonOnClick:(id)sender {
    if(!_headsBool || !_tailsBool){
        [EasyShowTextView showText:@"请上传身份证照!"];
        return;
    }
    
    if([_realNameField.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请填写姓名!"];
        return;
    }
    if([_sexField.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请填写性别!"];
        return;
    }
    if([_ethincField.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请填写民族!"];
        return;
    }
    if([_birthdayField.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请填写出生日期!"];
        return;
    }
    if([_idCardNumberField.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请填写证件号!"];
        return;
    }
    if([_signEndDateField.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请填写证件有效期!"];
        return;
    }
    if([_addressField.text isEqualToString:@""]){
        [EasyShowTextView showText:@"请填写户籍详细地址!"];
        return;
    }
    if([_regAdreeBtn.titleLabel.text isEqualToString:@"请选择"]){
        [EasyShowTextView showText:@"请选择户籍所在地!"];
        return;
    }
    NSString *loginName = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    // 如果上传成功，跳转到信息显示界面
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    [parames setObject:loginName forKey:@"loginName"];
    [parames setObject:loginName forKey:@"phoneNo"];
    [parames setObject:_frontPicPath forKey:@"frontPicPath"];
    [parames setObject:_backPicPath forKey:@"backPicPath"];
    [parames setObject:self.verificationData forKey:@"image3dcheck"];
    [parames setObject:_realNameField.text forKey:@"realName"];
    [parames setObject:_sexField.text forKey:@"sex"];
    [parames setObject:_ethincField.text forKey:@"ethnic"];
    [parames setObject:_idCardNumberField.text forKey:@"idCardNumber"];
    [parames setObject:_birthdayField.text forKey:@"birthday"];
    
    [parames setObject:_signdate forKey:@"signdate"];
    [parames setObject:_expirydate forKey:@"expirydate"];
    //  户籍地址
    NSString *residenceAddress = [_regAdreeBtn.titleLabel.text stringByAppendingString:[NSString stringWithFormat:@" %@",_addressField.text]];
    
    NSArray *regAddress = [_regAdreeBtn.titleLabel.text componentsSeparatedByString:@" "];
    // 户籍地址省
    NSString *regprovince = @"";
    NSString *regcity = @"";
    NSString *regarea = @"";
    // 户籍地址市
    // 区
    if([regAddress count] == 2){
        regprovince = regAddress[0];
        regcity = regAddress[0];
        regarea = regAddress[1];
    }else if([regAddress count] == 3){
        regprovince = regAddress[0];
        regcity = regAddress[1];
        regarea = regAddress[2];
    }
   
    [parames setObject:residenceAddress forKey:@"residenceAddress"];
    [parames setObject:regprovince forKey:@"regprovince"];
    [parames setObject:regcity forKey:@"regcity"];
    [parames setObject:regarea forKey:@"regarea"];
    
    paramesAddDictionary(parames);
//    NSLog(@"%@",[parames yy_modelToJSONString]);
    NSLog(@"%@",[STools dictJsonString: parames]);
    [EasyShowLodingView showLodingText:@"请稍等..."];
    [session POST:url_RealName parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[responseObject yy_modelToJSONString]);
              // 关闭HUD
              [EasyShowLodingView hidenLoding];
              if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                  
                  @try {
                      NSDictionary *result = [responseObject objectForKey:@"result"];
                      // 保存用户信息（ 静态数据保存 ）
                      [DataManage share].userModel = [UserModel userWithDic:result];
                      // 显示成功页面
                      AuthResultViewController *resultVc = [[AuthResultViewController alloc]init];
                      [self.navigationController pushViewController:resultVc animated:YES];
                  }
                  @catch (NSException *exception) {
                      NSLog(@"%s %d\n%@",__FUNCTION__,__LINE__, exception);
                
                  }
              
              }else if([[responseObject objectForKey:@"respCode"] isEqualToString:@"01"]){
                  NSString *msg = @"人脸信息相似度较低，识别未通过，请重新进行人脸识别";
                  [self showAlert:@"识别未通过" message:msg black:^(NSString *str) {
                      
                  }];
                  
              }else if([[responseObject objectForKey:@"respCode"] isEqualToString:@"-99"]||
                       [[responseObject objectForKey:@"respCode"] isEqualToString:@"99"]){
                  [EasyShowTextView showErrorText:@"服务器数据异常，请稍后再试!"];
              }else{
                  [EasyShowTextView showErrorText:@"认证失败!"];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];

}

- (void)showAlert:(NSString*)title message:(NSString*)message  black:(void (^ __nullable)(NSString*))handler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@">>> Click the yes button.");
        handler(@"YES");
    }];

    [alertController addAction:yesAction];
    //show alert controller
    [self presentViewController:alertController animated:YES completion:nil];
    
}
/**
 * 地址选择
 */
- (IBAction)selectAddress:(id)sender {
    __weak typeof (self) weakSelf = self;
    ChooseLocationController *locationVc = [[ChooseLocationController alloc]init];
    [locationVc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    locationVc.block = ^(NSString *address,NSString *code){
         if(address !=nil)
         [weakSelf.regAdreeBtn setTitle:address forState:UIControlStateNormal];
    };
    [self presentViewController:locationVc animated:NO completion:nil];  
}


- (IBAction)headerPhoto:(id)sender {
    NSLog(@"手势点击事件响应 --- 身份证正面照");
//    [self localIdcardOCROnlineFront];
    _photoType = HEADS;
    [self idcardOCROnlineFront];
}

- (IBAction)tailsPhotoAction:(id)sender {
    NSLog(@"手势点击事件响应 --- 身份证反面照");
    _photoType = TAILS;
    [self idcardOCROnlineBack];
}

# pragma mark ORC 身份证 读取
// 普通拍照读取 和 自动识别 两种，选择一种
// 身份证正面
- (void)idcardOCROnlineFront {
    
    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont
                        andImageHandler:^(UIImage *image) {
                            [[AipOcrService shardService]
                             detectIdCardFrontFromImage:image
                             withOptions:nil
                             successHandler:self->successHandler
                             failHandler:self->failHandler];
                            
                            //上传图片
                            [self uploadImage:image type:HEADS];
                        }];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
// 身份证正面(嵌入式质量控制+云端识别)
- (void)localIdcardOCROnlineFront {
    
    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeLocalIdCardFont
                        andImageHandler:^(UIImage *image) {
                            [[AipOcrService shardService]
                             detectIdCardFrontFromImage:image
                             withOptions:nil
                             successHandler:^(id result){
                                 self->successHandler(result);
                                     // 这里可以存入相册
                                     //UIImageWriteToSavedPhotosAlbum(image, nil, nil, (__bridge void *)self);
                                 }
                                 failHandler:self->failHandler];

                            //上传图片
                             [self uploadImage:image type:HEADS];
                        }];
    [self presentViewController:vc animated:YES completion:nil];
 
}


// 身份证反面拍照识别
- (void)idcardOCROnlineBack{
    
    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack
                          andImageHandler:^(UIImage *image) {
                              [[AipOcrService shardService]
                               detectIdCardBackFromImage:image
                                             withOptions:nil
                                          successHandler:self->successHandler
                                             failHandler:self->failHandler];
                              //上传图片
                              [self uploadImage:image type:TAILS];
                          }];
    [self presentViewController:vc animated:YES completion:nil];
}
// 身份证反面(嵌入式质量控制+云端识别)
- (void)localIdcardOCROnlineBack{
    
    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeLocalIdCardBack
                         andImageHandler:^(UIImage *image) {
                             [[AipOcrService shardService]
                              detectIdCardBackFromImage:image
                                            withOptions:nil
                            successHandler:^(id result){
                                self->successHandler(result);
                                // 这里可以存入相册
                                // UIImageWriteToSavedPhotosAlbum(image, nil, nil, (__bridge void *)self);
                              }
                              //上传图片
                              failHandler:self->failHandler];
                             [self uploadImage:image type:TAILS];
                         }];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark 识别成功后显示数据
-(void)setData:(id)result{
    _idCardModel = [ORCIDCardModel orcIdCardWithDic:_idCardModel dict:result];
    NSLog(@"_idCardModel = %@",[_idCardModel yy_modelToJSONString]);
    [_realNameField setText:_idCardModel.name];
    _sexField.text = _idCardModel.sex;
    _ethincField.text = _idCardModel.ethnic;
    _birthdayField.text = _idCardModel.birthday;
    _idCardNumberField.text = _idCardModel.idNumber;
    _signEndDateField.text = [_idCardModel.signDate stringByAppendingString:[NSString stringWithFormat:@"-%@",_idCardModel.expiryDate]];
    if(!_idCardModel.signDate){
        _signdate = [DateUtils dateFormatter:_idCardModel.signDate beforePattren:@"yyyyMMdd" afterPattren:@"yyyy-MM-dd"];
    }
    if(!_idCardModel.expiryDate){
       _expirydate = [DateUtils dateFormatter:_idCardModel.expiryDate beforePattren:@"yyyyMMdd" afterPattren:@"yyyy-MM-dd"];
    }
    
}

#pragma mark 识别成功的回调
- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    // 这是默认的识别成功的回调
    self->successHandler = ^(id result){
       NSLog(@"result = %@", [result yy_modelToJSONString]);
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            if(weakSelf.photoType == HEADS){
                weakSelf.headsBool = true;
            }else if(weakSelf.photoType == TAILS){
                weakSelf.tailsBool = true;
            }
           [weakSelf setData:result];
        });
    };
    
    self->failHandler = ^(NSError *error){
        NSLog(@"_failHandler %@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            if(weakSelf.photoType == HEADS){
                [weakSelf.HeadsImage setImage:[UIImage imageNamed:@"name_confirm_pic_positive.png"]];
                weakSelf.headsBool = false;
            }else if(weakSelf.photoType == TAILS){
                [weakSelf.tailsImage setImage:[UIImage imageNamed:@"name_confirm_pic_reverse.png"]];
                weakSelf.tailsBool = false;
            }
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
}

#pragma  mark 上传图片
-(void)uploadImage :(UIImage *)image type:(int)type{
     __weak typeof(self) weakSelf = self;
    NSData *imageData = [STools compressImage:image toByte:byteLength];
    //传入的参数
    NSMutableDictionary *parames = [[NSMutableDictionary alloc]init];
    [parames setObject:[imageData base64EncodedString] forKey:@"uploadFile"];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer=[AFJSONRequestSerializer serializer];

    NSLog(@"%@",[parames yy_modelToJSONString]);
    
    [EasyShowLodingView showLodingText:@"图片上传中..."];
    [session POST:url_uploadFile parameters:parames progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success--%@",[responseObject yy_modelToJSONString]);
              // 关闭HUD
              [EasyShowLodingView hidenLoding];
              if([[responseObject objectForKey:@"respCode"] isEqualToString:@"00"]){
                  // 显示登录成功toast
                  [EasyShowTextView showSuccessText:@"上传成功!"];
                  if(type == HEADS){
                     weakSelf.frontPicPath = [responseObject objectForKey:@"filePath"];
                      [weakSelf.HeadsImage setImage:image];
                  }else{
                      weakSelf.backPicPath = [responseObject objectForKey:@"filePath"];
                       [weakSelf.tailsImage setImage:image];
                  }
                  
              }else{
                  [EasyShowTextView showErrorText:@"上传失败!"];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [EasyShowLodingView hidenLoding];
              [EasyShowTextView showText:@"请求失败!"];
              NSLog(@"failure--%@",error);
          }];

}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
