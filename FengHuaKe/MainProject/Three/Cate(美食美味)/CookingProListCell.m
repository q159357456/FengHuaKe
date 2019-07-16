//
//  CookingProListCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingProListCell.h"
@interface CookingProListCell()
@property(nonatomic,strong)UIImageView * logo;
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)UILabel * label3;
@property(nonatomic,strong)UILabel * label4;
@end
@implementation CookingProListCell

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
        
        self.label4 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label4];
        [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.logo.mas_bottom);
            make.left.mas_equalTo(self.logo.mas_right).offset(5*MULPITLE);
            make.size.mas_equalTo(CGSizeMake(300*MULPITLE, 20*MULPITLE));
        }];
        
        self.label1.font = ZWHFont(14*MULPITLE);
        self.label2.font = ZWHFont(14*MULPITLE);
        self.label3.font = ZWHFont(14*MULPITLE);
        self.label4.font = [UIFont boldSystemFontOfSize:16];
        self.label4.textColor = [UIColor redColor];
        self.label2.textColor = [UIColor lightGrayColor];
    }
    return self;
}
-(void)loadData:(ProductModel*)model{
    ImageCacheDefine(self.logo, model.url);
    self.label1.text = model.proname;
    self.label2.text = model.brand;
    self.label3.text = [NSString stringWithFormat:@"月售:%@",model.sellnums];
    self.label4.text = [NSString stringWithFormat:@"￥%.2f",[model.minPrice floatValue]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
