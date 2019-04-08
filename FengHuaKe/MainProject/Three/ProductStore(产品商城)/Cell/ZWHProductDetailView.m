//
//  ZWHProductDetailView.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/13.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHProductDetailView.h"

@implementation ZWHProductDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self setUP];
    }
    return self;
}

-(void)setUP{
    [self addSubview:self.topScrView];
    [self.topScrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.height.mas_equalTo(HEIGHT_PRO(200));
    }];
    
    _name = [[QMUILabel alloc]init];
    _name.font = HTFont(32);
    _name.text = @"abdd";
    [self addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topScrView.mas_bottom).offset(HEIGHT_PRO(15));
        make.left.equalTo(self).offset(WIDTH_PRO(8));
    }];
    
    _share = [[QMUIButton alloc]init];
    [_share setImage:[UIImage imageNamed:@"share"] forState:0];
    //[_share sizeToFit];
    [self addSubview:_share];
    [_share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_name);
        make.right.equalTo(self).offset(-WIDTH_PRO(8));
        //make.width.height.mas_equalTo(WIDTH_PRO(35));
    }];
    
    _price = [[QMUILabel alloc]init];
    _price.font = HTFont(40);
    _price.text = @"¥25.55";
    _price.textColor = [UIColor redColor];
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_name.mas_bottom).offset(HEIGHT_PRO(10));
        make.left.equalTo(self).offset(WIDTH_PRO(8));
    }];
    
    _type = [[QMUILabel alloc]init];
    _type.font = HTFont(20);
    _type.text = @"踏青囤货价";
    _type.textColor = [UIColor whiteColor];
    _type.contentEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    _type.backgroundColor = [UIColor redColor];
    [self addSubview:_type];
    [_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_price);
        make.left.equalTo(_price.mas_right).offset(WIDTH_PRO(15));
    }];
    
    _oldprice = [[QMUILabel alloc]init];
    _oldprice.font = HTFont(24);
    _oldprice.text = @"价格:25.55";
    _oldprice.textColor = ZWHCOLOR(@"#808080");
    [self addSubview:_oldprice];
    [_oldprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_price.mas_bottom).offset(HEIGHT_PRO(10));
        make.left.equalTo(self).offset(WIDTH_PRO(8));
    }];
    
    _express = [[QMUILabel alloc]init];
    _express.font = HTFont(24);
    _express.text = @"快递:0";
    _express.textColor = ZWHCOLOR(@"#808080");
    [self addSubview:_express];
    [_express mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-HEIGHT_PRO(8));
        make.left.equalTo(self).offset(WIDTH_PRO(8));
    }];
    
    _num = [[QMUILabel alloc]init];
    _num.font = HTFont(24);
    _num.text = @"月销量";
    _num.textColor = ZWHCOLOR(@"#808080");
    _num.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_num];
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_express);
        make.centerX.equalTo(self);
    }];
    
    _address = [[QMUILabel alloc]init];
    _address.font = HTFont(24);
    _address.text = @"地址";
    _address.textColor = ZWHCOLOR(@"#808080");
    _address.textAlignment = NSTextAlignmentRight;
    [self addSubview:_address];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_express);
        make.right.equalTo(self).offset(-WIDTH_PRO(8));
    }];
}

-(void)setModel:(ProductDetailModel *)model{
    _model = model;
    if (_model.PictureList.count>0) {
        NSMutableArray *arr = [NSMutableArray array];
        for (PictureModel *model in _model.PictureList) {
            [arr addObject:[NSString stringWithFormat:@"%@%@",SERVER_IMG,model.url]];
        }
        _topScrView.imageURLStringsGroup = arr;
    }
    _name.text = _model.proname;
    _price.text = [NSString stringWithFormat:@"¥%@",_model.minsaleprice];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"价格:%@",_model.maxsaleprice] attributes:attribtDic];
    _oldprice.attributedText = attribtStr;
    
    _num.text = [NSString stringWithFormat:@"月销量%@件",_model.sellnums];
    _address.text = _model.proplace;
    
    
}

#pragma mark - getter

-(SDCycleScrollView *)topScrView{
    if (!_topScrView) {
        NSArray *array = @[[UIImage imageNamed:@"WechatIMG2"]];
        _topScrView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(200)) delegate:nil placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
        _topScrView.localizationImageNamesGroup = array;
        _topScrView.backgroundColor = [UIColor whiteColor];
        _topScrView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _topScrView.pageControlBottomOffset = 5;
        _topScrView.pageControlDotSize = CGSizeMake(WIDTH_PRO(7.5), HEIGHT_PRO(7));
        _topScrView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _topScrView.currentPageDotColor = MAINCOLOR;
        _topScrView.pageDotColor = [UIColor whiteColor];
        _topScrView.autoScroll = YES;
    }
    return _topScrView;
}


@end
