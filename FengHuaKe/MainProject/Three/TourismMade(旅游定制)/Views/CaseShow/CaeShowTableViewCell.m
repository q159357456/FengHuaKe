//
//  CaeShowTableViewCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CaeShowTableViewCell.h"

@implementation CaeShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentimageView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.contentimageView];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
        
        self.label1.backgroundColor = [UIColor redColor];
        self.label2.backgroundColor = [UIColor redColor];
        self.contentimageView.backgroundColor = [UIColor redColor];
        
        [self.contentimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.contentView.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, WIDTH_PRO(120)));
        }];
        
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, WIDTH_PRO(20)));
            make.left.mas_equalTo(self).offset(10);
            make.top.mas_equalTo(self.contentimageView.mas_bottom).offset(10);
        }];
        
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10);
            make.top.mas_equalTo(self.label1.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, WIDTH_PRO(20)));
        }];
        
     
    }
    return self;
}
+(CGFloat)rowHeight{
    
    return 10+WIDTH_PRO(20)+10+ WIDTH_PRO(120)+WIDTH_PRO(20)+10;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
