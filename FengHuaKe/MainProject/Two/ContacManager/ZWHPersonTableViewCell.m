//
//  ZWHPersonTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/20.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHPersonTableViewCell.h"

@implementation ZWHPersonTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    CellLine;
    
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(15));
    }];
    
    
    _detail = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor qmui_colorWithHexString:@"808080"]];
    [self.contentView addSubview:_detail];
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_title.mas_right).offset(WIDTH_PRO(15));
    }];
    
}

-(void)setImageArr:(NSArray *)imageArr{
    
    [_title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(WIDTH_PRO(15));
        make.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
    
    _imageArr = imageArr;
    CGFloat wid = WIDTH_PRO(60);
    for (NSInteger i=0;i<(_imageArr.count>3?3:_imageArr.count);i++) {
        NSString *log = _imageArr[i];
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,log]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        [self.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(wid);
            make.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
            make.left.equalTo(_title.mas_right).offset(WIDTH_PRO(15)+i*(wid+WIDTH_PRO(8)));
        }];
    }
}




@end
