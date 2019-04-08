//
//  ZWHVisaDetailViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/12/21.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVisaDetailViewController.h"
#import "CatageModel.h"
#import "POP.h"
#import "ChatViewController.h"
#import "ZWHServiceListViewController.h"

@interface ZWHVisaDetailViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UITableView *listTableView;

@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)CatageModel *model;
@property (nonatomic, strong)UIWebView *detailWebView;

@property (nonatomic, strong)UIView *explanView;
@property (nonatomic, assign)BOOL isexplanShow;

@end

@implementation ZWHVisaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签证须知";
    _isexplanShow = NO;
    [self getVisaDetail];
}

-(void)setUI{
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _listTableView.showsVerticalScrollIndicator = NO;
    _listTableView.showsHorizontalScrollIndicator = NO;
    _listTableView.separatorStyle = 0;
    [self.view addSubview:_listTableView];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    
    _listTableView.tableHeaderView = self.headerView;
    _listTableView.tableFooterView = self.detailWebView;
    
    QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:nil title:@"联系客服"];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.backgroundColor = MAINCOLOR;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    [btn addTarget:self action:@selector(canshow) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self showDetail];
}

#pragma mark - 显示参考价说明
-(void)showPriceExplanWith:(QMUIButton *)btn{
    if (_isexplanShow) {
        [self.explanView removeFromSuperview];
        _isexplanShow = NO;
    }else{
        [self.view addSubview:self.explanView];
        POPSpringAnimation* springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        //它会先缩小到(0.5,0.5),然后再去放大到(1.0,1.0)
        springAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
        springAnimation.toValue =[NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        springAnimation.springBounciness = 20;
        [self.explanView.layer pop_addAnimation:springAnimation forKey:@"SpringAnimation"];
        _isexplanShow = YES;
    }
    
}



#pragma mark - 获取详情
-(void)getVisaDetail{
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getCaseSingle:@{@"para1":_code,@"para2":@"D001"} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            //NSLog(@"%@",obj);
            weakSelf.model = [CatageModel mj_objectWithKeyValues:obj[@"DataList"][0]];
            [weakSelf setUI];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getVisaDetail)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getVisaDetail)];
    }];
}

#pragma mark - 咨询客服
-(void)canshow{
    ZWHServiceListViewController *vc = [[ZWHServiceListViewController alloc]init];
    vc.shopid = _model.shopid;
    vc.para1 = @"D001";
    vc.para2 = _model.secondclass;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 查看详情
-(void)showDetail{
    //sender.selected = !sender.selected;
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:15px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>",_model.content];
    //[self.detailWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.detailWebView loadHTMLString:htmlString baseURL:nil];
    /*"for(var p in  $img){\n"
     " $img[p].style.width = '100%%';\n"
     "$img[p].style.height ='auto'\n"
     "}\n"*/
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize fsize = [self.detailWebView sizeThatFits:CGSizeZero];
        self.detailWebView.frame = CGRectMake(0, 0, fsize.width, fsize.height);
        [self.listTableView beginUpdates];
        self.listTableView.tableFooterView = self.detailWebView;
        [self.listTableView endUpdates];
    }
}

#pragma mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    

    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width - 20];
    [self.detailWebView stringByEvaluatingJavaScriptFromString:js];
    //[self.detailWebView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    [self.detailWebView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];

    NSInteger width = [[self.detailWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"] integerValue];
    CGFloat bili = width/SCREEN_WIDTH;
    NSInteger height = [[self.detailWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];


    self.detailWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height/bili);
    self.listTableView.tableFooterView = nil;
    self.listTableView.tableFooterView = self.detailWebView;
    [self.listTableView reloadData];
}


#pragma mark - getter
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(120))];
        _headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc]init];
        [_headerView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_headerView).offset(WIDTH_PRO(10));
            make.width.height.mas_equalTo(WIDTH_PRO(100));
        }];
        [img layoutIfNeeded];
        
        QMUILabel *priceL = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        [_headerView addSubview:priceL];
        [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img);
            make.left.equalTo(img.mas_right).offset(WIDTH_PRO(12));
        }];
        
        QMUIButton *explanBtn = [[QMUIButton alloc]init];
        explanBtn.backgroundColor = [UIColor qmui_colorWithHexString:@"BBBBBB"];
        explanBtn.titleLabel.font = ZWHFont(11);
        [explanBtn setTitle:@"?" forState:0];
        [explanBtn setTitleColor:[UIColor whiteColor] forState:0];
        explanBtn.layer.cornerRadius = WIDTH_PRO(15/2.f);
        explanBtn.layer.masksToBounds = YES;
        [_headerView addSubview:explanBtn];
        //explanBtn.frame = CGRectMake(SCREEN_WIDTH-WIDTH_PRO(30), WIDTH_PRO(10), WIDTH_PRO(15), WIDTH_PRO(15));
        [explanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(priceL);
            make.right.equalTo(_headerView).offset(-WIDTH_PRO(15));
            make.width.height.mas_equalTo(WIDTH_PRO(15));
        }];
        [explanBtn layoutIfNeeded];
        
        [explanBtn addTarget:self action:@selector(showPriceExplanWith:) forControlEvents:UIControlEventTouchUpInside];
        
        QMUILabel *priceNumber = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor redColor]];
        [_headerView addSubview:priceNumber];
        [priceNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(priceL);
            make.right.equalTo(explanBtn.mas_left).offset(-WIDTH_PRO(3));
        }];
        
        QMUILabel *addressTit = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        [_headerView addSubview:addressTit];
        [addressTit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(img.mas_centerY).offset(-HEIGHT_PRO(6));
            make.left.equalTo(priceL);
        }];
        
        QMUILabel *address = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        [_headerView addSubview:address];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(addressTit);
            make.right.equalTo(explanBtn.mas_right);
        }];
        
        QMUILabel *timeTit = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        [_headerView addSubview:timeTit];
        [timeTit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_centerY).offset(HEIGHT_PRO(6));
            make.left.equalTo(priceL);
        }];
        
        QMUILabel *time = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        [_headerView addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(timeTit);
            make.right.equalTo(explanBtn.mas_right);
        }];
        
        QMUILabel *phoneTit = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        [_headerView addSubview:phoneTit];
        [phoneTit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(img.mas_bottom);
            make.left.equalTo(priceL);
        }];
        
        QMUILabel *phone = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
        [_headerView addSubview:phone];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(phoneTit);
            make.right.equalTo(explanBtn.mas_right);
        }];
        
        
        
        phone.text = _model.contact;
        phoneTit.text = @"联系电话";
        time.text = _model.handle;
        timeTit.text = @"办理时间:";
        addressTit.text = @"办理地点:";
        priceNumber.text = [NSString stringWithFormat:@"¥%@",_model.likenum];
        priceL.text = @"参考价:";
        address.text = _model.tips;
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.imgsrc]] placeholderImage:[UIImage qmui_imageWithColor:[UIColor qmui_randomColor]]];
    }
    return _headerView;
}

-(UIWebView *)detailWebView{
    if (!_detailWebView) {
        _detailWebView.delegate = self;
        _detailWebView.scrollView.scrollEnabled = NO;
    }
    return _detailWebView;
}

-(UIView *)explanView{
    if (!_explanView) {
        _explanView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PRO(30), ZWHNavHeight+WIDTH_PRO(30), SCREEN_WIDTH-WIDTH_PRO(60), HEIGHT_PRO(100))];
        _explanView.backgroundColor = [UIColor whiteColor];
        _explanView.layer.borderColor = [MAINCOLOR CGColor];
        _explanView.layer.borderWidth = 1;
        _explanView.layer.cornerRadius = 3;
        _explanView.layer.masksToBounds = YES;
        QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(12) textColor:MAINCOLOR];
        [_explanView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_explanView).offset(6);
            make.bottom.right.equalTo(_explanView).offset(-6);
        }];
        lab.text = @"费用说明:\n1.包括使馆费用+服务费用。\n2.服务费包括:咨询+填报+翻译+预约+审核资料+代送代取取签证。\n3.不包含其他未提及费用。";
        lab.numberOfLines = 0;
    }
    return _explanView;
}





@end
