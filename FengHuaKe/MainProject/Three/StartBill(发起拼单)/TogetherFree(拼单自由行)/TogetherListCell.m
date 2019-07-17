//
//  TogetherListCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/17.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "TogetherListCell.h"
@interface TogetherListCell()
@property(nonatomic,strong)UIImageView * logo;
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)UILabel * label3;
@end
@implementation TogetherListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.logo = [[UIImageView alloc]init];
        [self.contentView addSubview:self.logo];
        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80*MULPITLE, 80*MULPITLE));
            make.top.mas_equalTo(self.contentView).offset(10*MULPITLE);
            make.left.mas_equalTo(self.contentView).offset(10*MULPITLE);
        }];
        
        self.label1 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.logo.mas_right).offset(5*MULPITLE);
            make.top.mas_equalTo(self.logo);
            make.height.mas_equalTo(20*MULPITLE);
        }];
        
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.label1.mas_bottom);
            make.left.mas_equalTo(self.logo.mas_right).offset(5*MULPITLE);
            make.size.mas_equalTo(CGSizeMake(300*MULPITLE, 20*MULPITLE));
        }];
        
        self.label3 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label3];
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.label2.mas_bottom);
            make.left.mas_equalTo(self.logo.mas_right).offset(5*MULPITLE);
            make.size.mas_equalTo(CGSizeMake(300*MULPITLE, 20*MULPITLE));
        }];
        
       
        
        self.label1.font = ZWHFont(14*MULPITLE);
        self.label2.font = ZWHFont(14*MULPITLE);
        self.label3.font = ZWHFont(14*MULPITLE);
        self.label2.textColor = [UIColor lightGrayColor];
    }
    return self;
}
-(void)loadData:(GroupBillModel *)model
{
    ImageCacheDefine(self.logo, model.url);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
