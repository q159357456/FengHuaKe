//
//  ZWHVacationListTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHVacationListTableViewCell.h"

@implementation ZWHVacationListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUI{
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:PLACEHOLDER]];
    _img.layer.cornerRadius = 8;
    _img.layer.masksToBounds = YES;
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.height.mas_equalTo(HEIGHT_PRO(150));
    }];
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    _title.text = @"-";
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_left).offset(WIDTH_PRO(15));
        make.top.equalTo(_img.mas_bottom).offset(WIDTH_PRO(3));
        make.right.equalTo(_img.mas_right);
        //make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(15));
    }];
    
    
    
    _detail = [[QMUILabel alloc]qmui_initWithFont:HTFont(24) textColor:[UIColor grayColor]];
    [self.contentView addSubview:_detail];
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_left).offset(WIDTH_PRO(15));
        make.top.equalTo(_title.mas_bottom).offset(WIDTH_PRO(3));
        make.bottom.equalTo(self.contentView).offset(-HEIGHT_PRO(15));
        make.right.equalTo(_img.mas_right);
    }];
    _detail.text = @"-";
    
    _detail.numberOfLines = 0;
    
    
    _price = [[QMUILabel alloc]qmui_initWithFont:HTFont(32) textColor:[UIColor whiteColor]];
    _price.text = @"¥0起";
    _price.backgroundColor = [UIColor orangeColor];
    _price.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_img);
        make.height.mas_equalTo(HEIGHT_PRO(25));
        make.right.equalTo(_img.mas_right);
        make.width.mas_equalTo(WIDTH_PRO(50));
    }];
    [_price layoutIfNeeded];
    [_price round:HEIGHT_PRO(12.5) RectCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft];
    
    CellLine;
    
    
    
}

-(void)setModel:(TravelListModel *)model{
    _model = model;
    _price.text = [NSString stringWithFormat:@"¥%@起",_model.saleprice];
    _title.text = _model.proname;
    _detail.text = _model.material;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
}




@end
