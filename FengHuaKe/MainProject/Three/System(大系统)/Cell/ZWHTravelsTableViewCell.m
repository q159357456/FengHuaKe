//
//  ZWHTravelsTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHTravelsTableViewCell.h"

@implementation ZWHTravelsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    CellLine;
    
    
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:PLACEHOLDER]];
    [self.contentView addSubview:_img];
    
    
    _titleL = [[UILabel alloc]init];
    _titleL.text = @"-";
    _titleL.font = HTFont(32);
    [self.contentView addSubview:_titleL];
    
    
    
    _eye = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan"]];
    [self.contentView addSubview:_eye];
    
    
    
    _numL = [[UILabel alloc]init];
    _numL.text = @"666";
    _numL.font = HTFont(22);
    _numL.textColor = ZWHCOLOR(@"#808080");
    _numL.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_numL];
    
    
    
    
    
    _timeL = [[UILabel alloc]init];
    _timeL.text = @"666";
    _timeL.font = HTFont(22);
    _timeL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeL];
    
    
    
    _detailL = [[UILabel alloc]init];
    _detailL.text = @"666";
    _detailL.font = HTFont(28);
    [self.contentView addSubview:_detailL];
    
    
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WIDTH_PRO(170));
            make.height.mas_equalTo(HEIGHT_PRO(110));
            make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
            make.top.equalTo(self.contentView).offset(HEIGHT_PRO(8));
        }];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
            make.right.equalTo(_img.mas_left).offset(-WIDTH_PRO(8));
            make.top.equalTo(_img.mas_top);
        }];
        [_eye mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WIDTH_PRO(21));
            make.height.mas_equalTo(WIDTH_PRO(13));
            make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
            make.bottom.equalTo(_img.mas_bottom).offset(-HEIGHT_PRO(3));
        }];
        [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_eye.mas_right).offset(WIDTH_PRO(8));
            make.centerY.equalTo(_eye);
        }];
        [_numL layoutIfNeeded];
        [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_img.mas_left).offset(-WIDTH_PRO(8));
            make.centerY.equalTo(_numL);
        }];
        
        [_detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_img.mas_left).offset(-WIDTH_PRO(8));
            make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
            make.top.equalTo(_titleL.mas_bottom).offset(HEIGHT_PRO(8));
            make.bottom.equalTo(_numL.mas_top).offset(-WIDTH_PRO(8));
        }];
        _detailL.numberOfLines = 0;
    
}


-(void)setModel:(CatageModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.imgsrc]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    _titleL.text = _model.title;
    _detailL.text = _model.content;
    _numL.text = _model.looknum;
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";
    NSDate *timeDate = [format dateFromString:_model.createdate];
    format.dateFormat = @"yyyy-MM-dd";
    _timeL.text = [NSString stringWithFormat:@"%@",[format stringFromDate:timeDate]];
}

@end
