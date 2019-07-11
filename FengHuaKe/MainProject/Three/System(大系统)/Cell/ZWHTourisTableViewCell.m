//
//  ZWHTourisTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTourisTableViewCell.h"

@implementation ZWHTourisTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine;
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"-";
    _titleL.font = HTFont(32);
    [self.contentView addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:PLACEHOLDER]];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_PRO(131));
        make.height.mas_equalTo(HEIGHT_PRO(100));
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.top.equalTo(_titleL.mas_bottom).offset(HEIGHT_PRO(8));
    }];
    
    _numL = [[UILabel alloc]init];
    _numL.text = @"666";
    _numL.font = HTFont(22);
    _numL.textColor = ZWHCOLOR(@"#808080");
    _numL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_numL];
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    
    [_numL layoutIfNeeded];
    
    _eye = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan"]];
    [self.contentView addSubview:_eye];
    [_eye mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_PRO(21));
        make.height.mas_equalTo(WIDTH_PRO(13));
        make.right.equalTo(_numL.mas_left).offset(-WIDTH_PRO(8));
        make.centerY.equalTo(_numL);
    }];
    
    _timeL = [[UILabel alloc]init];
    _timeL.text = @"666";
    _timeL.font = HTFont(22);
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_eye.mas_left).offset(-WIDTH_PRO(8));
        make.centerY.equalTo(_numL);
    }];

    
    _detailL = [[UILabel alloc]init];
    _detailL.text = @"666";
    _detailL.font = HTFont(28);
    [self.contentView addSubview:_detailL];
    [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
        make.left.equalTo(_img.mas_right).offset(WIDTH_PRO(8));
        make.top.equalTo(_titleL.mas_bottom).offset(HEIGHT_PRO(8));
        make.bottom.equalTo(_numL.mas_top).offset(-WIDTH_PRO(8));
    }];
    
    _detailL.numberOfLines = 0;
    
}

-(void)setModel:(CatageModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.imgsrc]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    _titleL.text = _model.title;
    _detailL.text = _model.breviary;
    _numL.text = _model.looknum;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    NSDate *timeDate = [format dateFromString:_model.createdate];
    format.dateFormat = @"yyyy-MM-dd";
    _timeL.text = [NSString stringWithFormat:@"%@",[format stringFromDate:timeDate]];
}


@end
