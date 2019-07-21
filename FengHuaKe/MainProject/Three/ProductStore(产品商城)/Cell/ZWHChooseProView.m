//
//  ZWHChooseProView.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHChooseProView.h"
#import "UIButton+IndexPath.h"


#define CANSELECT ZWHCOLOR(@"#808080")

@interface ZWHChooseProView()



//按钮存储数组
@property(nonatomic,strong)NSMutableArray *sumBtnArr;


//已选择按钮
@property(nonatomic,strong)QMUIGhostButton *specBtn;
@property(nonatomic,strong)QMUIGhostButton *colorBtn;
@property(nonatomic,strong)QMUIGhostButton *modelnumBtn;

//默认有3大类 规格颜色尺码
@property(nonatomic,assign)NSInteger typeNum;



//存储已存选择
@property(nonatomic,strong)NSMutableArray *alreadyArray;

@end

@implementation ZWHChooseProView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setDetailModel:(ProductDetailModel *)detailModel{
    _detailModel = detailModel;
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    _sumBtnArr = [NSMutableArray array];
    
    _typeNum = 3;
    [self setUP];
    [self setHeader];
    [self setFooter];
    [self setBottom];
}

/*spec color modelnum*/
-(void)setUP{
    UIColor *color = [[UIColor alloc]initWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.5];
    self.backgroundColor = color;
    
    _chooseTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _chooseTable.separatorStyle = 0;
    _chooseTable.bounces = NO;
    [self addSubview:_chooseTable];
    [_chooseTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        //make.height.mas_equalTo(HEIGHT_PRO(300));
        make.top.equalTo(self).offset(HEIGHT_PRO(260));
        make.bottom.equalTo(self).offset(-HEIGHT_PRO(50));
    }];
}

-(void)setBottom{
    UIView *view = [[UIView alloc]init];
    
    _addShopCar=[[QMUIButton alloc]init];;
    _goPay=[[QMUIButton alloc]init];
    
    [_addShopCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    NSString * title = [GroupBuyMananger singleton].isGroupStyle?@"拼单拼团":@"立即购买";
    [_goPay setTitle:title forState:UIControlStateNormal];
    
    [_addShopCar addTarget:self action:@selector(addToCarMethod) forControlEvents:UIControlEventTouchUpInside];
    [_goPay addTarget:self action:@selector(paytoMethod) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_addShopCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_goPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _addShopCar.backgroundColor=[UIColor orangeColor];
    _goPay.backgroundColor=[UIColor redColor];
    
    [view addSubview:_addShopCar];
    [view addSubview:_goPay];
    
    [_goPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(view);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [_addShopCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(view);
        make.right.equalTo(_goPay.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(HEIGHT_PRO(50));
    }];
    
}

-(void)setHeader{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(110));
    view.backgroundColor = [UIColor clearColor];
    
    UIView *white = [[UIView alloc]init];
    white.backgroundColor = [UIColor whiteColor];
    white.frame = CGRectMake(0, HEIGHT_PRO(30), SCREEN_WIDTH, HEIGHT_PRO(80));
    [view addSubview:white];
    
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(HEIGHT_PRO(110));
        make.top.equalTo(self).offset(HEIGHT_PRO(150));
    }];
    
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:PLACEHOLDER]];
    _img.frame = CGRectMake(WIDTH_PRO(30), 0, WIDTH_PRO(100), WIDTH_PRO(100));
    _img.layer.cornerRadius = WIDTH_PRO(8);
    _img.layer.masksToBounds = YES;
    [view addSubview:_img];
    
    _price = [[QMUILabel alloc]init];
    _price.font = HTFont(28);
    _price.textColor = [UIColor redColor];
    _price.text = [NSString stringWithFormat:@"¥%@",_detailModel.minsaleprice];
    [view addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(HEIGHT_PRO(40));
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(15));
    }];
    
    _num = [[QMUILabel alloc]init];
    _num.font = HTFont(28);
    _num.textColor = [UIColor blackColor];
    _num.text = [NSString stringWithFormat:@"库存%@件",_detailModel.total];
    [view addSubview:_num];
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_price.mas_bottom).offset(HEIGHT_PRO(6));
        make.left.equalTo(_price.mas_left);
    }];
    
    _type = [[QMUILabel alloc]init];
    _type.font = HTFont(28);
    _type.textColor = [UIColor blackColor];
    _type.text = [NSString stringWithFormat:@"请选择规格"];
    [view addSubview:_type];
    [_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_num.mas_bottom).offset(HEIGHT_PRO(15));
        make.left.equalTo(_price.mas_left);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LINECOLOR;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

//显示选项
-(void)setFooter{
    
    UIView *footer = [[UIView alloc]init];
    
    //一共有几大类
    if (_detailModel.ColorList.count==0) {
        _typeNum = 1;
    }else if (_detailModel.ModelList.count==0){
        _typeNum = 2;
    }
    
    _alreadyArray = [NSMutableArray array];
    for (NSInteger i=0;i<_typeNum;i++) {
        [_alreadyArray addObject:@""];
    }
    
    //总高度
    CGFloat hig=0;
    
    
    NSArray *titleArr = @[@"规格",@"颜色",@"尺码"];
    NSArray *modelArr = @[_detailModel.SpecList,_detailModel.ColorList,_detailModel.ModelList];
    for (NSInteger i=0; i<_typeNum; i++) {
        UIView *oneView = [[UIView alloc]init];
        oneView.backgroundColor = [UIColor whiteColor];
        [footer addSubview:oneView];
        UIView *oneline = [[UIView alloc]init];
        oneline.backgroundColor = LINECOLOR;
        [oneView addSubview:oneline];
        [oneline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(oneView);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *onelab = [[UILabel alloc]init];
        onelab.text = titleArr[i];
        onelab.font = HTFont(28);
        [oneView addSubview:onelab];
        [onelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneView).mas_equalTo(WIDTH_PRO(8));
            make.top.equalTo(oneView).mas_equalTo(WIDTH_PRO(8));
        }];
        
        QMUIFloatLayoutView *onelayView = [[QMUIFloatLayoutView alloc]init];
        onelayView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
        onelayView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
        
        //按钮数组
        NSMutableArray *mutaArray = [NSMutableArray array];
        
        //获得大类中的分类
        NSArray *array = modelArr[i];
        for (NSInteger j=0; j<array.count; j++) {
            QMUIGhostButton *button = [[QMUIGhostButton alloc] init];
            [mutaArray addObject:button];
            button.ghostColor = CANSELECT;
            switch (i) {
                case 0:
                {
                    SpecModel *model = array[j];
                    [button setTitle:model.spec forState:UIControlStateNormal];
                }
                    break;
                case 1:
                {
                    ColorModel *model = array[j];
                    [button setTitle:model.color forState:UIControlStateNormal];
                }
                    break;
                case 2:
                {
                    SizeModel *model = array[j];
                    [button setTitle:model.modelnum forState:UIControlStateNormal];
                }
                    break;
                default:
                    break;
            }
            
            button.titleLabel.font = UIFontMake(14);
            button.contentEdgeInsets = UIEdgeInsetsMake(3, 16, 3, 16);
            [onelayView addSubview:button];
            //标记IndexPath
            button.syindexPath = [NSIndexPath indexPathForRow:j inSection:i];
            [button addTarget:self action:@selector(chooseViewWith:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        //将每组数组添加进总数组
        [_sumBtnArr addObject:mutaArray];
        
        CGSize floatLayoutViewSize = [onelayView sizeThatFits:CGSizeMake(SCREEN_WIDTH-WIDTH_PRO(16), CGFLOAT_MAX)];
        
        [oneView addSubview:onelayView];
        [onelayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneView).mas_equalTo(WIDTH_PRO(8));
            make.top.equalTo(onelab.mas_bottom).mas_equalTo(WIDTH_PRO(0));
            make.right.equalTo(oneView).mas_equalTo(-WIDTH_PRO(8));
            make.height.mas_equalTo(floatLayoutViewSize.height);
        }];
        
        [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(footer);
            make.height.mas_equalTo(floatLayoutViewSize.height+HEIGHT_PRO(40));
            make.top.equalTo(footer).mas_offset(hig);
        }];
        [oneView layoutIfNeeded];
        hig+=oneView.frame.size.height;
        
        
        //设置加减
        if (i==_typeNum-1) {
            UIView *numView = [[UIView alloc]init];
            
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = LINECOLOR;
            [numView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(numView);
                make.height.mas_equalTo(1);
            }];
            
            UILabel *numtitle = [[UILabel alloc]init];
            numtitle.text = @"购买数量";
            numtitle.font = HTFont(28);
            [numView addSubview:numtitle];
            [numtitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(numView);
                make.left.equalTo(numView).offset(WIDTH_PRO(8));
            }];
            
            QMUIButton *addbtn = [[QMUIButton alloc]init];
            [addbtn setTitle:@"+" forState:0];
            [addbtn setTitleColor:[UIColor blackColor] forState:0];
            addbtn.backgroundColor = LINECOLOR;
            [numView addSubview:addbtn];
            [addbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(numView);
                make.width.mas_equalTo(WIDTH_PRO(40));
                make.height.mas_equalTo(HEIGHT_PRO(30));
                make.right.equalTo(numView).offset(-WIDTH_PRO(8));
            }];
            [addbtn addTarget:self action:@selector(addNumWith:) forControlEvents:UIControlEventTouchUpInside];
            
            _chooseNum = [[UILabel alloc]init];
            _chooseNum.text = @"1";
            _chooseNum.font = HTFont(28);
            _chooseNum.backgroundColor = LINECOLOR;
            _chooseNum.textAlignment = NSTextAlignmentCenter;
            _chooseNum.textColor = [UIColor blackColor];
            [numView addSubview:_chooseNum];
            [_chooseNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(numView);
                make.right.equalTo(addbtn.mas_left).offset(-WIDTH_PRO(8));
                make.width.mas_equalTo(WIDTH_PRO(40));
                make.height.mas_equalTo(HEIGHT_PRO(30));
            }];
            
            QMUIButton *reduceBtn = [[QMUIButton alloc]init];
            [reduceBtn setTitle:@"-" forState:0];
            [reduceBtn setTitleColor:[UIColor blackColor] forState:0];
            reduceBtn.backgroundColor = LINECOLOR;
            [numView addSubview:reduceBtn];
            [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(numView);
                make.width.mas_equalTo(WIDTH_PRO(40));
                make.height.mas_equalTo(HEIGHT_PRO(30));
                make.right.equalTo(_chooseNum.mas_left).offset(-WIDTH_PRO(8));
            }];
            [reduceBtn addTarget:self action:@selector(reduceNumWith:) forControlEvents:UIControlEventTouchUpInside];
            
            [footer addSubview:numView];
            [numView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oneView.mas_bottom);
                make.left.right.equalTo(footer);
                make.height.mas_equalTo(HEIGHT_PRO(40));
            }];
            [numView layoutIfNeeded];
            hig+=numView.frame.size.height;
        }
    }
    
    
    
    footer.frame = CGRectMake(0, 0, SCREEN_WIDTH, hig);
    _chooseTable.tableFooterView = footer;
    
}

#pragma mark - 加入购物车 购买
-(void)addToCarMethod{
    if (_productModel==nil) {
        [self showHint:@"请完成选择"];
        return;
    }
    NSInteger num = [_chooseNum.text integerValue];
    if (num > [_productModel.safestock integerValue]) {
        [self showHint:[NSString stringWithFormat:@"超过最大购买数量(%@件)",_productModel.safestock]];
        return;
    }else{
        if (_goCar) {
            _goCar(_productModel,num);
        }
    }
}

-(void)paytoMethod{
    if (_productModel==nil) {
        [self showHint:@"请完成选择"];
        return;
    }
    NSInteger num = [_chooseNum.text integerValue];
    if (num > [_productModel.safestock integerValue]) {
        [self showHint:[NSString stringWithFormat:@"超过最大购买数量(%@件)",_productModel.safestock]];
        return;
    }else{
        if (_payNow) {
            _payNow(_productModel,num);
        }
    }
}


#pragma mark - 加减
-(void)addNumWith:(QMUIButton *)btn{
    NSLog(@"+");
    NSInteger i = [_chooseNum.text integerValue];
    i++;
    _chooseNum.text = [NSString stringWithFormat:@"%ld",i];
}

-(void)reduceNumWith:(QMUIButton *)btn{
    NSLog(@"-");
    NSInteger i = [_chooseNum.text integerValue];
    if (i==1) {
        return;
    }
    i--;
    _chooseNum.text = [NSString stringWithFormat:@"%ld",i];
}

#pragma mark - 选择
-(void)chooseViewWith:(QMUIGhostButton *)btn{
    [self setNextCanChooseBtn:btn.syindexPath.section withBtn:btn];
}

//判断下一行有多少选择
-(void)setNextCanChooseBtn:(NSInteger)section withBtn:(QMUIGhostButton *)btn{
    //判断是否可选
    if([self samColor:btn.ghostColor withColor:LINECOLOR]){
        return;
    }else{
        //取消锁定的规格
        _productModel = nil;
        
        //判断是否已经是选中的
        if([self samColor:btn.ghostColor withColor:MAINCOLOR]){
            btn.ghostColor = CANSELECT;
            [_alreadyArray replaceObjectAtIndex:btn.syindexPath.section withObject:@""];
        }else{
            //重置颜色 因为之前可以选所以重置后依然可选
            for (QMUIGhostButton *ghostBtn in _sumBtnArr[section]) {
                if ([self samColor:ghostBtn.ghostColor withColor:MAINCOLOR]) {
                    ghostBtn.ghostColor = CANSELECT;
                }
                
            }
            btn.ghostColor = MAINCOLOR;
            [_alreadyArray replaceObjectAtIndex:btn.syindexPath.section withObject:btn.titleLabel.text];
        }
            
            //把其他的全部设置为不可选 如果已经选择则不设置
            for (NSInteger i=0; i<_sumBtnArr.count; i++) {
                if (i == section) {
                    continue;
                }
                NSMutableArray *btnArr = _sumBtnArr[i];
                for (NSInteger j=0; j< btnArr.count; j++) {
                    QMUIGhostButton *ghostBtn = btnArr[j];
                    if ([self samColor:ghostBtn.ghostColor withColor:MAINCOLOR]) {
                        continue;
                    }
                    ghostBtn.ghostColor = LINECOLOR;
                }
            }
            
        
            //找到包含这一类型的 产品模型
            for (ProductSpecModel *productModel in _detailModel.ProductSpecList) {
                NSArray *remarkArr;
                //三种规格存储
                if (_typeNum==1) {
                    remarkArr = @[productModel.spec];
                }else if (_typeNum==2){
                    remarkArr = @[productModel.spec,productModel.color];
                }else{
                    remarkArr = @[productModel.spec,productModel.color,productModel.modelnum];
                }
                
                
                //遍历全部数组
                for (NSInteger i=0; i<_sumBtnArr.count; i++) {
                    if (i == section) {
                        continue;
                    }
                    //判断所有按钮是否可选
                    NSMutableArray *btnArr = _sumBtnArr[i];
                    
                    for (NSInteger j=0; j< btnArr.count; j++) {
                        QMUIGhostButton *ghostBtn = btnArr[j];
                        NSString *str = ghostBtn.titleLabel.text;
                        if ([str isEqualToString:@"灰白"]) {
                            NSLog(@"找到灰白");
                        }
                        if ([str isEqualToString:remarkArr[i]]) {
                            
                            BOOL isCanSelect=YES;
                            for (NSInteger x=0; x<_alreadyArray.count; x++) {
                                if (x==i) {
                                    continue;
                                }
                                
                                NSString *alreadyStr = _alreadyArray[x];
                                if (alreadyStr.length > 0) {
                                    if ([alreadyStr isEqualToString:remarkArr[x]]) {
                                        
                                    }else{
                                        isCanSelect = NO;
                                    }
                                }else{
                                    
                                }
                            }
                            if ([self samColor:ghostBtn.ghostColor withColor:MAINCOLOR]) {
                                continue;
                            }
                            if (isCanSelect) {
                                ghostBtn.ghostColor = CANSELECT;
                            }
                            
                            
                        }
                        
                    }
                }
            }
        
        [self getChooseProductModel];
        }
        
   // }
}

//检查是否全选完
-(void)getChooseProductModel{
    NSInteger sum=0;
    NSString *remark=@"";
    
    //判断是否全选完
    for (NSString *str in _alreadyArray) {
        if (str.length>0) {
            sum++;
        }
    }
    //选完之后的操作
    if (sum==_typeNum) {
        for (NSString *str in _alreadyArray) {
            if (str.length>0) {
                remark = [NSString stringWithFormat:@"%@%@",remark,str];
            }
        }
        
        for (ProductSpecModel *model in _detailModel.ProductSpecList) {
            if ([model.remark isEqualToString:remark]) {
                _productModel = model;
                [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_productModel.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
                _price.text = [NSString stringWithFormat:@"¥%@",_productModel.saleprice1];
                _num.text = [NSString stringWithFormat:@"库存%@件",_productModel.safestock];
                _type.text = remark;
            }
        }
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self HiddenView];
}

-(void)ShowView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)HiddenView{
    [self removeFromSuperview];
    /*[UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];*/
}


//判断颜色是否相同
-(BOOL)samColor:(UIColor*)firstColor withColor:(UIColor*)secondColor
{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void)showHint:(NSString *)hint
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

@end
