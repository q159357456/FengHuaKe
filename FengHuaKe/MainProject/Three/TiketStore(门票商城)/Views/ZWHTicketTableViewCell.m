//
//  ZWHTicketTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTicketTableViewCell.h"

@implementation ZWHTicketTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine;
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG2"]];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_PRO(104));
        make.height.mas_equalTo(HEIGHT_PRO(75));
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    
    _title = [[QMUILabel alloc]init];
    _title.font = HTFont(28);
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_img.mas_top);
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    
    _city = [[QMUILabel alloc]init];
    _city.font = HTFont(24);
    _city.textColor = ZWHCOLOR(@"#888888");
    [self.contentView addSubview:_city];
    [_city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(HEIGHT_PRO(3));
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
    }];
    
    _point = [[QMUILabel alloc]init];
    _point.font = HTFont(28);
    _point.textColor = MAINCOLOR;
    [self.contentView addSubview:_point];
    [_point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_city.mas_bottom).offset(HEIGHT_PRO(3));
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
    }];
    
    _saleNum = [[QMUILabel alloc]init];
    _saleNum.font = HTFont(24);
    _saleNum.textColor = ZWHCOLOR(@"#888888");
    [self.contentView addSubview:_saleNum];
    [_saleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_point);
        make.left.equalTo(_point.mas_right).offset(WIDTH_PRO(4));
    }];
    
    _price = [[QMUILabel alloc]init];
    _price.font = HTFont(28);
    _price.textColor = [UIColor blackColor];
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_img.mas_bottom);
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    
    
    
    _title.text = @"-";
    _city.text = @"广州";
    _point.text = @"4.5分";
    _saleNum.text = @"已售444";
    _price.text = @"¥233起";
    
}

-(void)setModel:(TicketListModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]]];
    _title.text = _model.proname;
    _city.text = _model.fitsex;
    _point.text = [NSString stringWithFormat:@"%@分",_model.grade];
    _saleNum.text = [NSString stringWithFormat:@"已售%@",_model.sellnums];
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.saleprice];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.saleprice]];
    NSRange range2=[text rangeOfString:@"起"];
    _price.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
    
    
    _tipsStr = _model.freight;
    
    [_tipsView removeFromSuperview];
    _tipsView = [[QMUIFloatLayoutView alloc]init];
    //_tipsView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    _tipsView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    [self.contentView addSubview:_tipsView];
    
    
    NSArray *arr = [_tipsStr componentsSeparatedByString:@"，"];
    
    for (NSInteger i=0; i<arr.count; i++) {
        QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:MAINCOLOR];
        lab.text = arr[i];
        lab.contentEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
        lab.qmui_borderColor = MAINCOLOR;
        lab.qmui_borderWidth = 1;
        lab.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight | QMUIViewBorderPositionBottom;
        lab.layer.cornerRadius = 3;
        lab.layer.masksToBounds = YES;
        [_tipsView addSubview:lab];
    }
    
    CGSize floatLayoutViewSize = [_tipsView sizeThatFits:CGSizeMake(SCREEN_WIDTH-WIDTH_PRO(150), CGFLOAT_MAX)];
    
    [_tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title.mas_left);
        make.bottom.equalTo(_img.mas_bottom);
        make.right.equalTo(_price.mas_left);
        make.height.mas_equalTo(floatLayoutViewSize.height);
    }];
    [_tipsView layoutIfNeeded];
    
}



@end
