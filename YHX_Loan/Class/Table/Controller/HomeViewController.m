//
//  HomeViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/23.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "HomeViewController.h"
#import "LoanAuthViewController.h"
#import "Permission.h"
#import "SPLoginViewController.h"
#import <ZYBannerView.h>
#import "MyUIPageControl.h"
#define BlueViewHeight 51//view51
@interface HomeViewController ()<ZYBannerViewDataSource, ZYBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headBackGround;
@property (weak, nonatomic) IBOutlet UIView *loanBgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBgheight;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UICollectionView *menuView;
@property (weak, nonatomic) IBOutlet UILabel *loanRange;
@property (weak, nonatomic) IBOutlet UIButton *gotoLoanBt;
// bannerVC
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeight;

@property (nonatomic, strong) ZYBannerView *banner;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HomeViewController

#pragma mark Getter

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"banner_01.png", @"banner_02.png", @"banner_03.png"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 控制器的 automaticallyAdjustsScrollViewInsets 属性为 YES(default) 时,
    // 若控制器的view及其子控件有唯一的一个 UIScrollView (或其子类), 那么这个
    // UIScrollView (或其子类)会被调整内边距
    [self EdgeInsets];
    [self setBgView];
    [self setBackView];
    [self setBanner];
   
    
}

-(void)setBackView{
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"home_icon_back.png"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"home_icon_back.png"]];
    // 设置返回键内容
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
}


/**
 * 小额贷按键监听
 */
- (IBAction)smallBtnClick:(id)sender {
    if([DataManage share].userModel != nil){
        self.hidesBottomBarWhenPushed=YES;
        LoanAuthViewController *loanAuthVc = [[LoanAuthViewController alloc]init];
        [LoanApplyModel share].promno = @"0101";
        [self.navigationController pushViewController:loanAuthVc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
        
    }else{
     
        [EasyShowTextView showText:@"请先登录"];
        
        SPLoginViewController *loginVc = [[SPLoginViewController alloc]init];
        [self pushViewController:loginVc];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


#pragma mark 设置Banner View
-(void)setBanner{
    // 初始化
    self.bannerHeight.constant = pcScreenWidth/3.0;
    self.banner = [[ZYBannerView alloc] init];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    [self.bannerView addSubview:self.banner];
    
    // 设置frame
    self.banner.frame = CGRectMake(0,0, pcScreenWidth,pcScreenWidth/3.0);
    // Should Loop
    self.banner.shouldLoop = YES;
    // Show Footer
    self.banner.showFooter = YES;
    // Auto Scroll
    self.banner.autoScroll = YES;
    [self.banner.pageControl setValue:[UIImage imageNamed:@"home_banner_normal"] forKeyPath:@"_pageImage"];
    [self.banner.pageControl setValue:[UIImage imageNamed:@"home_banner_btn"] forKeyPath:@"_currentPageImage"];

}

#pragma mark - ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return self.dataArray.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的v iew, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    // 取出数据
    NSString *imageName = self.dataArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

// 返回 Footer 在不同状态时要显示的文字
- (NSString *)banner:(ZYBannerView *)banner titleForFooterWithState:(ZYBannerFooterState)footerState
{
    if (footerState == ZYBannerFooterStateIdle) {
        return @"拖动加载";
    } else if (footerState == ZYBannerFooterStateTrigger) {
        return @"没有更多了";
    }
    return nil;
}

#pragma mark - ZYBannerViewDelegate

// 在这里实现点击事件的处理
- (void)banner:(ZYBannerView *)banner didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"点击了第%ld个项目", (long)index);
}

- (void)banner:(ZYBannerView *)banner didScrollToItemAtIndex:(NSInteger)index
{
//    NSLog(@"滚动到第%ld个项目", (long)index);
}

// 在这里实现拖动 Footer 后的事件处理
- (void)bannerFooterDidTrigger:(ZYBannerView *)banner
{
//    NSLog(@"触发了footer");

}

#pragma mark View初始化
- (void)setBgView {
    _loanBgView.layer.shadowColor = [UIColor grayColor].CGColor;//阴影颜色
    _loanBgView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    _loanBgView.layer.shadowOpacity = 0.5;//不透明度
    _loanBgView.layer.shadowRadius = 5.0;//半径
    _loanBgView.layer.cornerRadius = 5;
    
    //设置headView的背景图--渐变色
    self.headBgheight.constant = [SPToolBox statueHeight] + 140;
    //横幅
    UIImage *image = [UIImage imageNamed:@"home_bg.png"];
    self.headBackGround.layer.contents = (id) image.CGImage;
    self.headBackGround.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    
}

- (void) EdgeInsets{
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        UIEdgeInsets insets = UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
        _scrollView.contentInset = insets;
    }
    
}

-(void)pushViewController:(UIViewController *)viewController{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#  pragma mark 隐藏导航条
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if(![DataManage share].userModel){
        [_gotoLoanBt setTitle:@"未登录" forState:UIControlStateNormal];
    }else{
       [_gotoLoanBt setTitle:@"测试额度" forState:UIControlStateNormal];
    }
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
