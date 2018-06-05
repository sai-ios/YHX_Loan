//
//  NSWebViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/5/29.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "NSWebViewController.h"

@interface NSWebViewController ()<UIWebViewDelegate>
// webView
@property(nonatomic, strong) UIWebView *webView;
@end

@implementation NSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"协议";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, pcScreenWidth,pcScreenHeight)];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:self.url withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
    [_webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [EasyShowLodingView showLodingText:@"加载中"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
     [EasyShowLodingView hidenLoding];
    if(_jsonData!=nil)
     [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"insert(%@)",_jsonData]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [EasyShowLodingView hidenLoding];
    if(error.code == 404){
        NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"404.html" withExtension:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:filePath];
        [_webView loadRequest:request];
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
