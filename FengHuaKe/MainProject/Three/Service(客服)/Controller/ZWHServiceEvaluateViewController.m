//
//  ZWHServiceEvaluateViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/12/25.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHServiceEvaluateViewController.h"

@interface ZWHServiceEvaluateViewController ()

@property(nonatomic,strong)UITableView *listTableView;

@property(nonatomic,strong)NSMutableArray *xxArray;
@property(nonatomic,strong)NSMutableArray *tagArray;

@property(nonatomic,strong)NSMutableArray *tagBtnArray;

@property(nonatomic,strong)QMUILabel *evaluateL;

@property(nonatomic,strong)QMUITextView *otherText;

@property(nonatomic, strong)QMUIFloatLayoutView *floatLayoutView;

@property(nonatomic,assign)NSInteger levels;


@end

@implementation ZWHServiceEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tagBtnArray = [NSMutableArray array];
    self.title = @"客服评价";
    _levels = -1;
    [self getTagSource];
}

/**
 * 获得评价标签
 */
-(void)getTagSource{
    _tagArray = [NSMutableArray array];
    MJWeakSelf;
    [HttpHandler getCaseTag:@{@"para1":_serviceModel.shopid,@"para2":_para1,@"para3":_para2,@"para4":@""} start:@1 end:@10 querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            NSArray *ary = obj[@"DataList"];
            for (NSInteger i=0; i<ary.count; i++) {
                NSDictionary *dic = ary[i];
                [weakSelf.tagArray addObject:dic[@"text"]];
            }
            [weakSelf setUI];
        }
    } failed:^(id obj) {
        //[QMUITips showInfo:@"aaa"];
    }];
}

-(void)setUI{
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _listTableView.showsVerticalScrollIndicator = NO;
    _listTableView.showsHorizontalScrollIndicator = NO;
    _listTableView.separatorStyle = 0;
    _listTableView.backgroundColor = LINECOLOR;
    [self.view addSubview:_listTableView];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ZWHNavHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_PRO(50));
    }];
    
    QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:nil title:@"提交"];
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    [btn addTarget:self action:@selector(submitClickWith:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setheader];
    [self setfoot];
}

#pragma mark - 提交
-(void)submitClickWith:(QMUIButton *)btn{
    [self.view endEditing:YES];
    if (_levels<1) {
        [QMUITips showInfo:@"请选择评价星级"];
        return;
    }
    NSString *evalutateStr = @"";
    for (QMUIGhostButton *button in _tagBtnArray) {
        if (CGColorEqualToColor([button.backgroundColor CGColor], MAINCOLOR.CGColor)) {
            evalutateStr = [NSString stringWithFormat:@"%@%@;",evalutateStr,_tagArray[button.tag]];
        }
    }
    if (_otherText.hidden == NO) {
        if (_otherText.text.length>0) {
            NSString *str = [_otherText.text stringByReplacingOccurrencesOfString:@";" withString:@"；"];
            evalutateStr = [NSString stringWithFormat:@"%@%@",evalutateStr,str];
        }
    }else{
        if (evalutateStr.length>0) {
            evalutateStr = [evalutateStr qmui_stringByRemoveLastCharacter];
        }
    }
    
    NSLog(@"%@",evalutateStr);
    
    MJWeakSelf;
    [HttpHandler getCaseAppraise:@{@"para1":_serviceModel.code,@"para2":_serviceModel.shopid,@"para3":evalutateStr,@"para4":UniqUserID,@"intresult":[NSString stringWithFormat:@"%ld",_levels]} start:@(-1) end:@(-1) querytype:@"0" Success:^(id obj) {
        NSLog(@"%@",obj);
        if (ReturnValue == 1) {
            [QMUITips showSucceed:@"评价成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [QMUITips showError:obj[@"msg"]];
        }
    } failed:^(id obj) {
        //[QMUITips showInfo:@"aaa"];
    }];
    
}


-(void)setheader{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = LINECOLOR;
    
    
    UIView *topbackView =[[UIView alloc]init];
    topbackView.backgroundColor = [UIColor whiteColor];
    [header addSubview:topbackView];
    topbackView.frame = CGRectMake(0, HEIGHT_PRO(10), SCREEN_WIDTH, HEIGHT_PRO(60));
    
    UIImageView *icon = [[UIImageView alloc]init];
    [topbackView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topbackView);
        make.left.equalTo(topbackView).offset(WIDTH_PRO(15));
        make.width.height.mas_equalTo(WIDTH_PRO(44));
    }];
    
    QMUILabel *name = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor blackColor]];
    [topbackView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(WIDTH_PRO(6));
        make.top.equalTo(icon);
    }];
    
    /**
     * 显示星星数量，半星设置
     */
    float xNum = [_serviceModel.evaluate_01 floatValue]/[_serviceModel.quantity floatValue]*5;
    float pointNum = xNum - (NSInteger)xNum;
    for (NSInteger i=0; i<(NSInteger)xNum; i++) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xx"]];
        [topbackView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(WIDTH_PRO(6)+WIDTH_PRO(18)*i);
            make.width.height.mas_equalTo(WIDTH_PRO(16));
            make.bottom.equalTo(icon);
        }];
    }
    UIImageView *pointimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xx2"]];
    UIImage *img = [UIImage imageNamed:@"xx"];
    UIImageView *grayImg = [[UIImageView alloc]initWithImage:img];
    UIView *view = [[UIView alloc]init];
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    [pointimg addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(pointimg);
        make.width.equalTo(pointimg.mas_width).multipliedBy(pointNum);
    }];
    [view addSubview:grayImg];
    [grayImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(view);
        make.width.mas_equalTo(WIDTH_PRO(16));
    }];
    [topbackView addSubview:pointimg];
    [pointimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(WIDTH_PRO(6)+WIDTH_PRO(18)*(NSInteger)xNum);
        make.width.height.mas_equalTo(WIDTH_PRO(16));
        make.bottom.equalTo(icon);
    }];
    
    
    QMUILabel *orderNum = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(12) textColor:[UIColor qmui_colorWithHexString:@"#777777"]];
    [topbackView addSubview:orderNum];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pointimg.mas_right).offset(WIDTH_PRO(15));
        make.centerY.equalTo(pointimg);
    }];
    
    /**
     * 设置评价的五颗星星
     */
    _xxArray = [NSMutableArray array];
    CGFloat leftx = SCREEN_WIDTH/2-WIDTH_PRO(37)*2.5f-WIDTH_PRO(10);
    for (NSInteger i=0; i<5; i++) {
        QMUIButton *btn = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"xx2"] title:@""];
        btn.tag = i;
        [_xxArray addObject:btn];
        [btn addTarget:self action:@selector(xxChooseWith:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(WIDTH_PRO(37));
            make.top.equalTo(topbackView.mas_bottom).offset(HEIGHT_PRO(50));
            make.left.equalTo(header).offset(leftx+WIDTH_PRO(42)*i);
        }];
    }
    
    _evaluateL = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(16) textColor:[UIColor qmui_colorWithHexString:@"#F9B411"]];
    [header addSubview:_evaluateL];
    [_evaluateL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header);
        make.top.equalTo(topbackView.mas_bottom).offset(HEIGHT_PRO(104));
    }];
    
    
    orderNum.text = [NSString stringWithFormat:@"%@单",_serviceModel.quantity];
    name.text = _serviceModel.name;
    [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_serviceModel.logonurl]] placeholderImage:[UIImage qmui_imageWithColor:[UIColor qmui_randomColor]]];
    
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(222));
    self.listTableView.tableHeaderView = header;
}

-(void)setfoot{
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = LINECOLOR;
    
    QMUILabel *titleL = [[QMUILabel alloc]qmui_initWithFont:ZWHFont(14) textColor:[UIColor qmui_colorWithHexString:@"#777777"]];
    [footView addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(footView);
    }];
    
    [footView addSubview:self.floatLayoutView];
    CGSize floatLayoutViewSize = [self.floatLayoutView sizeThatFits:CGSizeMake(SCREEN_WIDTH-WIDTH_PRO(30), CGFLOAT_MAX)];
    [self.floatLayoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(WIDTH_PRO(15));
        make.right.equalTo(footView).offset(-WIDTH_PRO(15));
        make.top.equalTo(titleL.mas_bottom).offset(HEIGHT_PRO(10));
        make.height.mas_equalTo(floatLayoutViewSize.height);
    }];
    
    _otherText = [[QMUITextView alloc]init];
    _otherText.font = ZWHFont(14);
    _otherText.placeholder = @"说点什么吧";
    [footView addSubview:_otherText];
    [_otherText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(WIDTH_PRO(15));
        make.right.equalTo(footView).offset(-WIDTH_PRO(15));
        make.top.equalTo(_floatLayoutView.mas_bottom).offset(HEIGHT_PRO(15));
        make.height.mas_equalTo(HEIGHT_PRO(100));
    }];
    
    _otherText.hidden = YES;
    
    
    titleL.text = @"为客服点个赞";
    
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(306));
    self.listTableView.tableFooterView = footView;
}


#pragma mark - 星星点击
-(void)xxChooseWith:(QMUIButton *)btn{
    for (QMUIButton *button in _xxArray) {
        if (button.tag<=btn.tag) {
            [button setImage:[UIImage imageNamed:@"xx"] forState:0];
        }else{
            [button setImage:[UIImage imageNamed:@"xx2"] forState:0];
        }
    }
    
    switch (btn.tag) {
        case 0:
        {
            _levels = 5;
            _evaluateL.text = @"垃圾";
        }
            break;
        case 1:
        {
            _levels = 4;
            _evaluateL.text = @"特差";
        }
            break;
        case 2:
        {
            _levels = 3;
            _evaluateL.text = @"差评";
        }
            break;
        case 3:
        {
            _levels = 2;
            _evaluateL.text = @"中评";
        }
            break;
        case 4:
        {
            _levels = 1;
            _evaluateL.text = @"好评";
        }
            break;
        default:
            break;
    }
}

#pragma mark - 点击标签
-(void)tagClickWith:(QMUIGhostButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"+添加"]) {
        _otherText.hidden = !_otherText.hidden;
    }else{
        if (CGColorEqualToColor([btn.backgroundColor CGColor], [UIColor whiteColor].CGColor)) {
            btn.backgroundColor = MAINCOLOR;
            [btn setTitleColor:[UIColor whiteColor] forState:0];
        }else{
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor qmui_colorWithHexString:@"#777777"] forState:0];
        }
    }
    
}


#pragma mark - getter
-(QMUIFloatLayoutView *)floatLayoutView{
    if (!_floatLayoutView) {
        _floatLayoutView = [[QMUIFloatLayoutView alloc] init];
        _floatLayoutView.padding = UIEdgeInsetsZero;
        _floatLayoutView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
        _floatLayoutView.minimumItemSize = CGSizeMake(69, 29);
        [_tagArray addObject:@"+添加"];
        for (NSInteger i = 0; i < _tagArray.count; i++) {
            QMUIGhostButton *button = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorWhite];
            [button setTitle:_tagArray[i] forState:UIControlStateNormal];
            button.titleLabel.font = UIFontMake(14);
            button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
            button.backgroundColor = [UIColor whiteColor];
            button.tag = i;
            [button setTitleColor:[UIColor qmui_colorWithHexString:@"#777777"] forState:0];
            button.qmui_borderColor = [UIColor qmui_colorWithHexString:@"#777777"];
            [button addTarget:self action:@selector(tagClickWith:) forControlEvents:UIControlEventTouchUpInside];
            [_floatLayoutView addSubview:button];
            if (i<_tagArray.count-1) {
                [_tagBtnArray addObject:button];
            }
        }
        
    }
    return _floatLayoutView;
}



@end
