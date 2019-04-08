//
//  ZWHHotelRoomTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHHotelRoomTableViewCell.h"

@implementation ZWHHotelRoomTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    CellLine
    
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG2"]];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.height.width.mas_equalTo(WIDTH_PRO(60));
    }];
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    _title.text = @"-";
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.top.equalTo(_img.mas_top);
    }];
    
    _detail = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:ZWHCOLOR(@"#808080")];
    _detail.text = @"-";
    [self.contentView addSubview:_detail];
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title.mas_left);
        make.top.equalTo(_title.mas_bottom).offset(HEIGHT_PRO(5));
    }];
    
    _price = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor blackColor]];
    _price.text = @"-";
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title.mas_left);
        make.top.equalTo(_detail.mas_bottom).offset(HEIGHT_PRO(5));
    }];
    
    _collect = [[QMUIButton alloc]qmui_initWithImage:[UIImage imageNamed:@"WechatIMG20"] title:@"收藏"];
    [self.contentView addSubview:_collect];
    [_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(15));
        make.top.equalTo(_img.mas_top);
    }];
    
    _pay = [[QMUIButton alloc]init];
    [_pay setTitle:@"预定" forState:0];
    [_pay setTitleColor:[UIColor whiteColor] forState:0];
    _pay.backgroundColor = MAINCOLOR;
    _pay.titleLabel.font = HTFont(24);
    _pay.layer.cornerRadius = 5;
    _pay.layer.masksToBounds = YES;
    [self.contentView addSubview:_pay];
    [_pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(15));
        make.bottom.equalTo(_img.mas_bottom);
        make.width.mas_equalTo(WIDTH_PRO(50));
        make.height.mas_equalTo(HEIGHT_PRO(22));
    }];
}

-(void)setModel:(HotelRoomListModel *)model{
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]] placeholderImage:[UIImage imageNamed:@"WechatIMG2"]];
    _title.text=model.proname;
    _detail.text=[NSString stringWithFormat:@"%@|%@|%@",model.spec,model.modelnum,model.material];
    NSString *text=[NSString stringWithFormat:@"¥%@起",model.saleprice1];
    NSRange range1=[text rangeOfString:[NSString stringWithFormat:@"¥%@",model.saleprice1]];
    NSRange range2=[text rangeOfString:@"起"];
    _price.attributedText=[text Color:[UIColor redColor] ColorRange:range1 Font:[UIFont systemFontOfSize:10] FontRange:range2];
}



@end
