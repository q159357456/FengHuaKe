//
//  ZWHVacationDetailViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVacationDetailViewController.h"
#import "ZWHTravelModel.h"
#import "KJChangeUserInfoTableViewCell.h"
#import "ZWHVacationBillViewController.h"

@interface ZWHVacationDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property(nonatomic,strong)UITableView *detailTable;

@property(nonatomic,strong)QMUIFloatLayoutView *layView;

@property(nonatomic,strong)ZWHTravelModel *model;

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *valueArr;

@property (nonatomic, strong)UIWebView *detailWebView;

@property (nonatomic, strong)QMUIButton *selectBtn;

@end

@implementation ZWHVacationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = @[@"交通参考",@"旅游路径",@"标准住宿"];
    [self getDataSource];
}

#pragma mark - 网络请求
-(void)getDataSource{
    [self showEmptyViewWithLoading];
    MJWeakSelf;
    [HttpHandler getTravelSingle:@{@"para1":self.code} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        [weakSelf hideEmptyView];
        if (ReturnValue==1) {
            NSDictionary *dict = [HttpTool getDictWithData:obj[@"sysmodel"][@"strresult"]];
            [ZWHTravelModel mj_objectClassInArray];
            weakSelf.model = [ZWHTravelModel mj_objectWithKeyValues:dict];
            [weakSelf setUI];
        }else{
            [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
        }
    } failed:^(id obj) {
        [weakSelf hideEmptyView];
        [weakSelf showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(getDataSource)];
    }];
}

-(void)setUI{
    _valueArr = @[_model.Product.proplace,@"深圳直飞北京",_model.Product.brand];
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_PRO(50)) style:UITableViewStylePlain];
    [self.view addSubview:_detailTable];
    [_detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = 0;
    _detailTable.backgroundColor = LINECOLOR;
    _detailTable.showsVerticalScrollIndicator = NO;
    [_detailTable registerClass:[KJChangeUserInfoTableViewCell class] forCellReuseIdentifier:@"KJChangeUserInfoTableViewCell"];
    self.keyTableView = _detailTable;
    
    [self setHeader];
    self.detailTable.tableFooterView = self.detailWebView;
    [self showDetail];
}

#pragma mark - 头部视图详情
-(void)setHeader{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.Product.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    img.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(207));
    [headerView addSubview:img];
    
    QMUILabel *price = [[QMUILabel alloc]qmui_initWithFont:HTFont(36) textColor:[UIColor redColor]];
    price.text = [NSString stringWithFormat:@"¥%@/人起",_model.Product.saleprice];
    [headerView addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(WIDTH_PRO(8));
        make.top.equalTo(img.mas_bottom).offset(HEIGHT_PRO(6));
    }];
    
    QMUILabel *detail = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:[UIColor blackColor]];
    detail.text = @"厦门，别称鹭岛，简称鹭，福建省副省级城市、经济特区，东南沿海重要的中心城市、港口及风景旅游城市。";
    detail.numberOfLines = 2;
    [headerView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(WIDTH_PRO(8));
        make.top.equalTo(price.mas_bottom).offset(HEIGHT_PRO(8));
        make.right.equalTo(headerView).offset(-WIDTH_PRO(8));
    }];
    
    QMUILabel *point = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor grayColor]];
    //point.text = [NSString stringWithFormat:@"%@ 12万人去过",_model.Product.grade];
    NSString *text=[NSString stringWithFormat:@"%@ 12万人去过",_model.Product.grade];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"%@",_model.Product.grade]];
    NSRange range2=[text rangeOfString:@"12万人去过"];
    point.attributedText=[text Color:MAINCOLOR ColorRange:range1 Font:[UIFont systemFontOfSize:12] FontRange:range2];
    [headerView addSubview:point];
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(WIDTH_PRO(8));
        make.top.equalTo(detail.mas_bottom).offset(HEIGHT_PRO(4));
        //make.right.equalTo(headerView).offset(-WIDTH_PRO(8));
    }];
    
    UIView *fourBackView = [[UIView alloc]init];
    fourBackView.qmui_borderColor = LINECOLOR;
    fourBackView.qmui_borderWidth = 1;
    fourBackView.qmui_borderPosition = QMUIViewBorderPositionTop|QMUIViewBorderPositionBottom;
    [headerView addSubview:fourBackView];
    [fourBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headerView);
        make.top.equalTo(point.mas_bottom).offset(WIDTH_PRO(6));
        make.height.mas_equalTo(HEIGHT_PRO(30));
    }];
    
    NSArray *arr = @[[NSString stringWithFormat:@"导游讲解%@",_model.Product.fitobject],[NSString stringWithFormat:@"描叙相符%@",_model.Product.fitscene],
                     [NSString stringWithFormat:@"好评%@",_model.Product.grade],[NSString stringWithFormat:@"安排合理%@",_model.Product.fitsex]];
    CGFloat wid = (SCREEN_WIDTH-WIDTH_PRO(40))/4;
    CGFloat hig = HEIGHT_PRO(23);
    for (NSInteger i=0; i<arr.count; i++) {
        QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:[UIColor whiteColor]];
        lab.backgroundColor = MAINCOLOR;
        lab.layer.cornerRadius = hig/2;
        lab.layer.masksToBounds = YES;
        lab.text = arr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        [fourBackView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(fourBackView).offset((i+1)*WIDTH_PRO(8)+i*wid);
            make.centerY.equalTo(fourBackView);
            make.height.mas_equalTo(hig);
            make.width.mas_equalTo(wid);
        }];
    }
    
    //出发城市
    QMUILabel *startcity = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:ZWHCOLOR(@"808080")];
    startcity.text = @"出发城市";
    [headerView addSubview:startcity];
    [startcity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(WIDTH_PRO(8));
        make.top.equalTo(fourBackView.mas_bottom).offset(HEIGHT_PRO(6));
    }];
    [startcity layoutIfNeeded];
    
    _layView = [[QMUIFloatLayoutView alloc]init];
    _layView.padding = UIEdgeInsetsMake(0, 0, 0, 12);
    _layView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    [headerView addSubview:_layView];
    
    for (NSInteger i=0; i<_model.Spec.count; i++) {
        ZWHTravelSpecModel *model = _model.Spec[i];
        QMUIButton *button = [[QMUIButton alloc] init];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitle:model.spec forState:UIControlStateNormal];
        button.titleLabel.font = HTFont(24);
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
        button.layer.cornerRadius = 4;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.tag = i;
        button.layer.borderColor = button.tag==0?MAINCOLOR.CGColor:LINECOLOR.CGColor;
        if (i==0) {
            _selectBtn = button;
        }
        [_layView addSubview:button];
        [button addTarget:self action:@selector(chooseStartCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    CGSize floatLayoutViewSize = [_layView sizeThatFits:CGSizeMake(SCREEN_WIDTH-WIDTH_PRO(90), CGFLOAT_MAX)];
    
    [_layView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(WIDTH_PRO(90));
        make.right.equalTo(headerView);
        make.top.equalTo(startcity.mas_top);
        make.height.mas_equalTo(floatLayoutViewSize.height);
    }];
    
    
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, img.height+HEIGHT_PRO(130)+floatLayoutViewSize.height);
    _detailTable.tableHeaderView = headerView;
    [self addBottom];
}

#pragma mark - 选择出发城市
-(void)chooseStartCity:(QMUIButton *)btn{
    if (_selectBtn) {
        _selectBtn.layer.borderColor = LINECOLOR.CGColor;
    }
    btn.layer.borderColor = MAINCOLOR.CGColor;
    _selectBtn = btn;
}


#pragma mark - 设置底部按钮
-(void)addBottom{
    
    UIView *bottomview = [[UIView alloc]init];
    [self.view addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    
    UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth*0.4,self.view.height-64-50, ScreenWidth*0.6, 50)];
    [button2 setTitle:@"预定下单" forState:0];
    button2.backgroundColor=MainColor;
    [self.view addSubview:button2];
    
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomview);
        make.width.mas_equalTo(SCREEN_WIDTH*0.4);
    }];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = LINECOLOR;
    [bottomview addSubview:line];
    
    [button2 addTarget:self action:@selector(gotoBill) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 预定下单
-(void)gotoBill{
    ZWHVacationBillViewController *vc = [[ZWHVacationBillViewController alloc]init];
    vc.model = _model;
    vc.InsuranceCode = _InsuranceCode;
    ZWHTravelSpecModel *model = _model.Spec[_selectBtn.tag];
    vc.prospec = model.code;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?3:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KJChangeUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJChangeUserInfoTableViewCell" forIndexPath:indexPath];
    cell.isWidTitle = YES;
    cell.leftTitleStr = _titleArr[indexPath.row];
    cell.leftLable.textColor = ZWHCOLOR(@"808080");
    cell.leftLable.font = HTFont(28);
    cell.contentTex.text = _valueArr[indexPath.row];
    cell.contentTex.textAlignment = NSTextAlignmentLeft;
    cell.contentTex.enabled = NO;
    cell.view.hidden = YES;
    cell.selectionStyle = 0;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?0:HEIGHT_PRO(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(40))];
    view.backgroundColor = [UIColor whiteColor];
    
    
    QMUILabel *explan = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    explan.text = @"景点说明";
    [view addSubview:explan];
    [explan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(WIDTH_PRO(8));
        make.centerY.equalTo(view);
    }];
    
    return section==0?nil:view;
}

#pragma mark - 景点详情
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
                            "</html>",_model.Product.remark];
    [_detailWebView loadHTMLString:htmlString baseURL:nil];
    /*"for(var p in  $img){\n"
     " $img[p].style.width = '100%%';\n"
     "$img[p].style.height ='auto'\n"
     "}\n"*/
}

#pragma mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [self.detailWebView stringByEvaluatingJavaScriptFromString:js];
    [self.detailWebView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
    
    // 获取webView的高度
    CGFloat webViewHeight = [[self.detailWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    NSLog(@"%.f", webViewHeight);
    self.detailWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight);
    self.detailTable.tableFooterView = self.detailWebView;
    [self.detailTable reloadData];
}

-(UIWebView *)detailWebView{
    if (!_detailWebView) {
        _detailWebView = [[UIWebView alloc]init];
        _detailWebView.delegate = self;
    }
    return _detailWebView;
}




@end
