//
//  CatageDetailWebVC.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "CatageDetailWebVC.h"
#import "CatageManagerVM.h"
#import "UIViewController+HUD.h"
#import <WebKit/WebKit.h>
#import "CatageModel.h"
#import "Masonry.h"
@interface CatageDetailWebVC ()<WKNavigationDelegate,WKUIDelegate>
{
    UIButton *_likeButton;
    UILabel *_likeLable;
}
@property(nonatomic,strong)WKWebView *wkWebView;
@property(nonatomic,strong)UIView *webHeaderView;
@property(nonatomic,strong)CatageModel *catageModel;
@property (nonatomic, weak) UIProgressView *progressView;
@end

@implementation CatageDetailWebVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getsigleDetail];
}
#pragma mark -ui
-(void)setUp
{
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
    }];
    [_wkWebView loadHTMLString:self.catageModel.content baseURL:nil];
    self.title = @"详情";
}
- (void)setupProgressView
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(0,ZWHNavHeight, ScreenWidth, 5);
    
    [progressView setTrackTintColor:[UIColor colorWithRed:240.0/255
                                                    green:240.0/255
                                                     blue:240.0/255
                                                    alpha:1.0]];
    progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:progressView];
    
    _progressView = progressView;
}

#pragma mark - set/get
-(WKWebView*)wkWebView
{
    if (!_wkWebView) {
        _wkWebView=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
        _wkWebView.scrollView.contentInset = UIEdgeInsetsMake(80,0, 0, 0);
        _wkWebView.navigationDelegate=self;
        [_wkWebView.scrollView addSubview:self.webHeaderView];
        
        //[_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
        //[self setupProgressView];
    }
    return _wkWebView;
}
-(UIView *)webHeaderView
{
    if (!_webHeaderView) {
        _webHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0,-80, ScreenWidth, 80)];
//        _webHeaderView.backgroundColor=[UIColor redColor];
        UILabel *lable1=[[UILabel alloc]init];
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.font=[UIFont systemFontOfSize:17];
        lable1.numberOfLines=0;
        UILabel *lable2=[[UILabel alloc]init];
        lable2.font=[UIFont systemFontOfSize:13];
        lable2.textColor=[UIColor lightGrayColor];
       _likeLable=[[UILabel alloc]init];
       _likeLable.font=[UIFont systemFontOfSize:13];
       _likeLable.textColor=[UIColor lightGrayColor];
        _likeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"newLike"] forState:UIControlStateNormal];
       [_likeButton setBackgroundImage:[UIImage imageNamed:@"newLike_selet"] forState:UIControlStateSelected];
        _likeButton.backgroundColor=[UIColor whiteColor];
        [_likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
        if (self.catageModel.melike.integerValue) {
            _likeButton.selected=YES;
        }else
        {
             _likeButton.selected=NO;
        }
        
        [_webHeaderView addSubview:lable1];
        [_webHeaderView addSubview:lable2];
         [_webHeaderView addSubview:_likeLable];
         [_webHeaderView addSubview:_likeButton];
        //
        //self.title=self.catageModel.classname;
        lable1.text=self.catageModel.title;
        lable2.text=[NSString stringWithFormat:@"%@%@",self.catageModel.tips,[self.catageModel.fromdate componentsSeparatedByString:@"T"][0]];
        _likeLable.text=[NSString stringWithFormat:@"%@",self.catageModel.likenum];
        [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_webHeaderView.mas_top).offset(8);
            make.left.mas_equalTo(_webHeaderView.mas_left).offset(8);
            make.right.mas_equalTo(_webHeaderView.mas_right).offset(-8);
            make.height.mas_equalTo(38);
        }];
        [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(_webHeaderView.mas_left).offset(8);
           make.bottom.mas_equalTo(_webHeaderView.mas_bottom).offset(-8);
           make.size.mas_equalTo(CGSizeMake(200, 17));
        }];
 
        [_likeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_webHeaderView.mas_right).offset(-8);
            make.size.mas_equalTo(CGSizeMake(30, 17));
            make.bottom.mas_equalTo(_webHeaderView.mas_bottom).offset(-8);
        }];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(17, 17));
            make.bottom.mas_equalTo(_webHeaderView.mas_bottom).offset(-8);
            make.right.mas_equalTo(_likeLable.mas_left).offset(-1);
        }];
        
        
    }
    return _webHeaderView;
}
#pragma mark - net
-(void)getsigleDetail
{
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.code,@"para2":UniqUserID}];
    DefineWeakSelf;
    [CatageManagerVM NewSingleSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
        NSLog(@"dic--%@",dic);
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
            weakSelf.catageModel=[CatageModel getDatawithdic:dic][0];
            weakSelf.catageModel.content=[self reSizeImageWithHTML:weakSelf.catageModel.content ];
            [weakSelf setUp];
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
    } Fail:^(id erro) {
        
    }];
    
}
//点赞
-(void)likeNews
{
    //sysmodel.para1：新闻代码, sysmodel.para2：点赞人ID, sysmodel.blresult：取消点赞否
    [self showHudInView:self.view hint:@""];
    NSString *sysmodel=[DataProcess getJsonStrWithObj:@{@"para1":self.code,@"para2":UniqUserID,@"blresult":self.catageModel.melike}];
    DefineWeakSelf;
    [CatageManagerVM NewLikeSysmodel:sysmodel Success:^(id responseData) {
        NSDictionary *dic=(NSDictionary*)responseData;
//        NSLog(@"dic--%@",dic);
        [self hideHud];
        if ([dic[@"sysmodel"][@"blresult"] intValue]) {
       
            [weakSelf LikeChange];
        }else
        {
            [weakSelf showHint:dic[@"sysmodel"][@"msg"]];
            
        }
    } Fail:^(id erro) {
        [self hideHud];
    }] ;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didStartProvisionalNavigation");
    
    //开始加载的时候，让进度条显示
    //self.progressView.hidden = NO;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation");
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didFinishNavigation");
    
}
#pragma mark - private
- (NSString *)reSizeImageWithHTML:(NSString *)html {
    return [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@",ScreenWidth - 20, html];
}



-(void)LikeChange
{
    if (self.catageModel.melike.intValue==0) {
       
        self.catageModel.melike=@"1";
    }else
    {
         self.catageModel.melike=@"0";
    }
    _likeButton.selected=!_likeButton.selected;
    if (_likeButton.selected) {
        _likeLable.text=[NSString stringWithFormat:@"%ld",self.catageModel.likenum.integerValue+1];
       
    }else
    {
         _likeLable.text=[NSString stringWithFormat:@"%ld",self.catageModel.likenum.integerValue-1];
    }
    self.catageModel.likenum=_likeLable.text;
    
}

- (void)dealloc
{
    //[self.wkWebView removeObserver:self
                      //forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    //self.wkWebView.navigationDelegate = nil;
}

#pragma mark - action
-(void)like
{
    [self likeNews];
}
#pragma mark - KVO
/*-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress
                              animated:animated];
        
        if (self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressView setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0.0f animated:NO];
                             }];
        }
    }else{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
    
}*/

@end
