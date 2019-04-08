//
//  ZWHChoosePhotoTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHChoosePhotoTableViewCell.h"

@implementation ZWHChoosePhotoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CellLine;
    QMUILabel *lab = [[QMUILabel alloc]qmui_initWithFont:HTFont(26) textColor:[UIColor blackColor]];
    lab.text = @"上传到";
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(8));
        make.centerY.equalTo(self.contentView);
    }];
    
    UIImageView *rig = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"choosePhoto"]];
    [self.contentView addSubview:rig];
    [rig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(WIDTH_PRO(16));
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-WIDTH_PRO(8));
    }];
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(26) textColor:[UIColor blackColor]];
    _title.text = @"";
    _title.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rig.mas_left).offset(-WIDTH_PRO(8));
        make.centerY.equalTo(self.contentView);
    }];
    
    _img = [[UIImageView alloc]init];
    [self.contentView addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_title.mas_left).offset(-WIDTH_PRO(6));
        make.top.equalTo(self.contentView).offset(3);
        make.bottom.equalTo(self.contentView).offset(-3);
        make.width.equalTo(_img.mas_height);
    }];
}

@end
