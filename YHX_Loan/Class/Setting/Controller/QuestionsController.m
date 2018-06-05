//
//  QuestionsController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/31.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "QuestionsController.h"
#import "ImageCollectionViewCell.h"
#import <Photos/Photos.h>
#import "ImageCell.h"
//#import <mailcore2-ios/MailCore/MailCore.h>
#import <ZLPhotoModel.h>
#import <ZLPhotoManager.h>

#define maxImage 4
@interface QuestionsController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *addbtn;

@property(nonatomic, strong)   ZLPhotoActionSheet * actionSheet;
@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;
@property (nonatomic, strong) NSArray *arrDataSources;
@property (nonatomic, assign) BOOL isOriginal;
@property (nonatomic,strong) UIImage *addImageBt;
// emailsession
//@property(nonatomic, strong) MCOSMTPSession *smtpSession;
@property (nonatomic, strong) NSMutableArray<NSString *> *selectPhotoPaths;
// 福建，
@end

@implementation QuestionsController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题反馈";
    _addImageBt = [UIImage imageNamed:@"addImage"];
    [self initCollectionView];
    // 给导航条上添加一个加 “发送” ，并且有一个点击事件
    UIBarButtonItem *sendBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendEmail)];
    self.navigationItem.rightBarButtonItem = sendBtnItem;
    
    
}


- (void)initCollectionView
{
    self.collectionView.dataSource =self;
    self.collectionView.delegate = self;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((width-9)/4, (width-9)/4);
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView registerClass:NSClassFromString(@"ImageCell") forCellWithReuseIdentifier:@"ImageCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (IBAction)addClick:(id)sender {
    [[self getPas]  showPhotoLibrary] ;

}

#pragma mark 选择图片
- (ZLPhotoActionSheet *)getPas
{
    if(!_actionSheet)
        _actionSheet = [[ZLPhotoActionSheet alloc] init];
    
#pragma mark - 参数配置 optional，可直接使用 defaultPhotoConfiguration
    
    //以下参数为自定义参数，均可不设置，有默认值
    _actionSheet.configuration.allowSelectImage = YES;
    _actionSheet.configuration.allowSelectGif = NO;
    _actionSheet.configuration.allowSelectVideo = NO;
    _actionSheet.configuration.allowSelectLivePhoto = YES;
    _actionSheet.configuration.allowEditImage = YES;
    //设置相册内部显示拍照按钮
    _actionSheet.configuration.allowTakePhotoInLibrary = YES;
    //设置在内部拍照按钮上实时显示相机俘获画面
    _actionSheet.configuration.showCaptureImageOnTakePhotoBtn = NO;
    //设置照片最大预览数
    _actionSheet.configuration.maxPreviewCount = 20;
    //设置照片最大选择数
    _actionSheet.configuration.maxSelectCount = 4;
    //设置照片cell弧度
    _actionSheet.configuration.cellCornerRadio = 0;
    
    //是否在选择图片后直接进入编辑界面
    _actionSheet.configuration.editAfterSelectThumbnailImage = NO;
    //是否在已选择照片上显示遮罩层
    _actionSheet.configuration.showSelectedMask = NO;
    //颜色，状态栏样式
    _actionSheet.configuration.selectedMaskColor = [UIColor whiteColor];
    _actionSheet.configuration.navBarColor = [UIColor whiteColor];
    _actionSheet.configuration.navTitleColor = [UIColor blackColor];
    _actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
    _actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
    _actionSheet.configuration.bottomViewBgColor = [UIColor darkTextColor];
    _actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    _actionSheet.configuration.shouldAnialysisAsset = YES;
    
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    _actionSheet.sender = self;
    //记录上次选择的图片
    _actionSheet.arrSelectedAssets =self.lastSelectAssets;
    
    __weak typeof(self) weakSelf = self;
    [_actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        weakSelf.arrDataSources =images;
        weakSelf.lastSelectPhotos = images.mutableCopy;
       
        weakSelf.isOriginal = isOriginal;
        weakSelf.lastSelectAssets = assets.mutableCopy;
        
        [weakSelf.collectionView reloadData];
        
        
        weakSelf.selectPhotoPaths = [NSMutableArray array];

        for (PHAsset *asset in assets) {
            [ZLPhotoManager requestAssetFileUrl:asset complete:^(NSString *filePath) {
                NSLog(@"path::::: %@",filePath);
                [weakSelf.selectPhotoPaths addObject:filePath];
            }];
        }
        NSLog(@"%@",weakSelf.selectPhotoPaths);
    }];
    
    _actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");
    };
    
    return _actionSheet;
    
   
}


#pragma mark -collectionView 代理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.imageView.image = _arrDataSources[indexPath.row];
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrDataSources.count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_arrDataSources[indexPath.row] == _addImageBt){
         [[self getPas]  showPhotoLibrary] ;
    }else{
      [[self getPas] previewSelectedPhotos:self.lastSelectPhotos assets:self.lastSelectAssets index:indexPath.row isOriginal:self.isOriginal];
    }
    
    
}

#pragma mark -邮件发送
-(void)sendEmail{}
/*
-(void)sendEmail{
   _smtpSession = [[MCOSMTPSession alloc] init];
    _smtpSession.hostname = @"smtp.qq.com";//qq邮箱地址
    _smtpSession.port = 25;//qq邮箱端口号
    _smtpSession.username = @"3002851937@qq.com";
    _smtpSession.password = @"jnzjnayklcmedgaa";//qq邮箱开启SMTP服务之后的**授权码**不是邮箱原始的密码
    _smtpSession.connectionType = MCOConnectionTypeStartTLS;//https
    
    // 登录验证
    MCOSMTPOperation *smtpOperation = [self.smtpSession loginOperation];
    [smtpOperation start:^(NSError * error) {
        if (error == nil) {
            NSLog(@"login successed");
            [self buildMessage];
            
        } else {
            NSLog(@"login failure: %@", error);
        }
    }];
    
}

-(void)buildMessage
{
    // 构建邮件体的发送内容
    MCOMessageBuilder *messageBuilder = [[MCOMessageBuilder alloc] init];
    messageBuilder.header.from = [MCOAddress addressWithDisplayName:@"恒圆金服" mailbox:@"3002851937@qq.com"];   // 发送人
    messageBuilder.header.to = @[[MCOAddress addressWithMailbox:@"251716795@qq.com"]];       // 收件人（多人）
        messageBuilder.header.cc = @[[MCOAddress addressWithMailbox:@"942011355@qq.com"]];      // 抄送（多人）
    //    messageBuilder.header.bcc = @[[MCOAddress addressWithMailbox:@"444444@qq.com"]];    // 密送（多人）
    messageBuilder.header.subject = @"测试邮件";    // 邮件标题
    messageBuilder.textBody = @"hello world";     // 邮件正文
    
 
     //如果邮件是回复或者转发，原邮件中往往有附件以及正文中有其他图片资源，
     //如果有需要你可将原文原封不动的也带过去，这里发送的正文就可以如下配置
 
    NSString * bodyHtml = @"<p>我是原邮件正文</p>";
    NSString *body = @"我是邮件回复的内容";
    NSMutableString*fullBodyHtml = [NSMutableString stringWithFormat:@"%@<br/>-------------原始邮件-------------<br/>%@",[body stringByReplacingOccurrencesOfString:@"\n"withString:@"<br/>"],bodyHtml];
    [messageBuilder setHTMLBody:fullBodyHtml];
    
//    // 添加正文里的附加资源
//    NSArray *inattachments = fullBodyHtml.htmlInlineAttachments;
//    for (MCOAttachment *attachment in inattachments) {
//        [messageBuilder addRelatedAttachment:attachment];    //添加html正文里的附加资源（图片）
//    }
    
    for(NSString * path in self.selectPhotoPaths){
        NSData *fileData = [NSData dataWithContentsOfFile:path];
        MCOAttachment *attachment = [MCOAttachment attachmentWithData:fileData filename:path];
        [messageBuilder addAttachment:attachment];    //添加附件
    }
    
//    // 添加邮件附件
//    for (MCOAttachment*attachment in attachments) {
//        [messageBuilder addAttachment:attachment];    //添加附件
//    }
    
    [self sendMessage:messageBuilder];
}
-(void)sendMessage:(MCOMessageBuilder *)messageBuilder
{
    NSData * rfc822Data =[messageBuilder data];
    MCOSMTPSendOperation *sendOperation = [self.smtpSession sendOperationWithData:rfc822Data];
    [sendOperation start:^(NSError *error) {
        if (error == nil) {
            NSLog(@"send successed");
        } else {
            NSLog(@"send failure: %@", error);
        }
    }];
}
*/


@end
