//
//  MainTabBarController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/23.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //第一个 首页
    UINavigationController *homeNav = [[UIStoryboard storyboardWithName:@"home" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self addChildVc:homeNav title:@"首页" image:@"bottom_icon_home_normal" selectedImage:@"bottom_icon_home_pressed"];
    
    //第二个 贷款记录
    UINavigationController *LoanNav = [[UIStoryboard storyboardWithName:@"loanTable" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self addChildVc:LoanNav title:@"贷款记录" image:@"bottom_icon_loan_normal" selectedImage:@"bottom_icon_loan_pressed"];
    
    //第三个 个人中心
    UINavigationController *personalNav = [[UIStoryboard storyboardWithName:@"myCenter" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self addChildVc:personalNav title:@"个人中心" image:@"bottom_icon_my_normal" selectedImage:@"bottom_icon_my_pressed"];
  
}


- (void)setupTabBar
{
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
}


- (void)addChildVc:(UINavigationController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = XZColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = XZRGB(0xff9249);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    [self addChildViewController:childVc];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
