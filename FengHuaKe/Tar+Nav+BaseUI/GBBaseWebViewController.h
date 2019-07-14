//
//  GBBaseWebViewController.h
//  FengHuaKe
//
//  Created by chenheng on 2019/4/9.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GBBaseWebViewController : ZWHBaseViewController<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)WKWebView *webview;
@property(nonatomic,assign)BOOL navBarHidden;
@property(nonatomic,assign)BOOL showActivity;
@end

NS_ASSUME_NONNULL_END
