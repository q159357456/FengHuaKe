//
//  UserDefineCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/6/29.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "UserDefineCell.h"

@implementation UserDefineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}
-(void)initSubViews{
    
    self.label1 = [[UILabel alloc]init];
    self.label2 = [[UILabel alloc]init];
    self.label3 = [[UILabel alloc]init];
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label3.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
    [self.contentView addSubview:self.label3];
    
    self.label2.layer.cornerRadius = 8*MULPITLE;
    self.label2.layer.masksToBounds = YES;
    self.label2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.label2.text = @"广告";
    
    self.label1.font = ZWHFont(14*MULPITLE);
    self.label3.font = ZWHFont(14*MULPITLE);
    self.label2.font = ZWHFont(13*MULPITLE);
     [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.contentView).offset(15*MULPITLE);
         make.centerY.mas_equalTo(self);
         make.height.mas_equalTo(self);
         make.width.mas_equalTo(50*MULPITLE);
         
     }];
    
     [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.label1.mas_right).offset(15*MULPITLE);
         make.centerY.mas_equalTo(self);
         make.height.mas_equalTo(25*MULPITLE);
         make.width.mas_equalTo(45*MULPITLE);
     }];
    
     [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.label2.mas_right).offset(15*MULPITLE);
         make.centerY.mas_equalTo(self);
         make.height.mas_equalTo(self);
         make.right.mas_equalTo(self.mas_right).offset(-15*MULPITLE);
     }];
}

-(void)loadData:(DefineContentModel *)model
{
    self.label1.text = model.display_text;
    self.label3.text = model.display_value;
    
    CGSize size = [self.label1 sizeThatFits:CGSizeZero];
    [self.label1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
