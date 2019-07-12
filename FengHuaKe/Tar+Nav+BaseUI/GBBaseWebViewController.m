//
//  GBBaseWebViewController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/4/9.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import "GBBaseWebViewController.h"
@interface GBBaseWebViewController ()
@end

@implementation GBBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = UIColorWhite;
    [self.view addSubview:self.webview];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navBarHidden)
    {
        [self.navigationController setNavigationBarHidden:YES];
    }
  
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.webview.UIDelegate = nil;
    self.webview.navigationDelegate = nil;
    self.webview.scrollView.delegate = nil;
    if (self.navBarHidden)
    {
       [self.navigationController setNavigationBarHidden:NO];
    }
    
   
}


-(WKWebView *)webview
{
    if (!_webview) {
        CGRect react;
        if (self.navBarHidden)
        {
            react = CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant);
            
        }else
        {
            react = CGRectMake(0, 0, SCREEN_WIDTH, self.view.qmui_height);
            
        }
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        configuration.preferences = preferences;
        _webview = [[WKWebView alloc]initWithFrame:react configuration:configuration];
        _webview.UIDelegate = self;
        _webview.navigationDelegate = self;
        _webview.scrollView.delegate = self;
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.scrollView.showsHorizontalScrollIndicator =NO;
        _webview.scrollView.showsVerticalScrollIndicator = NO;

        
    }
    return _webview;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//}

#pragma mark - webDelegate
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"===didStartProvisionalNavigation=====");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    NSLog(@"===内容开始返回=====");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"===加载完成=====");
//    NSString *injectionJSString = @"var script = document.createElement('meta');"
//    "script.name = 'viewport';"
//    "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";"
//    "document.getElementsByTagName('head')[0].appendChild(script);";
//    [webView evaluateJavaScript:injectionJSString completionHandler:^(id _Nullable ret, NSError * _Nullable error) {
//    }];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    //    [MBProgressHUD hideHUDForView:self.webview];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"===页面加载失败=====");
    
    
}
// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"===接收到服务器跳转请求之后再执行=====");
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
//    if ([message.name isEqualToString:@"done"]) {
//        NSDictionary *dic = (NSDictionary*)message.body;
//        NSLog(@"dic--%@",dic);
//        if (dic) {
//            [self post_pay_addressAdressData:dic];
//        }
//    }
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get th- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message { 
 <#code#>
 }
 
 - (void)encodeWithCoder:(nonnull NSCoder *)aCoder { 
 <#code#>
 }
 
 - (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection { 
 <#code#>
 }
 
 - (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
 <#code#>
 }
 
 - (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize { 
 <#code#>
 }
 
 - (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container { 
 <#code#>
 }
 
 - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
 <#code#>
 }
 
 - (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
 <#code#>
 }
 
 - (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator { 
 <#code#>
 }
 
 - (void)setNeedsFocusUpdate { 
 <#code#>
 }
 
 - (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context { 
 <#code#>
 }
 
 - (void)updateFocusIfNeeded { 
 <#code#>
 }
 
 e new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
