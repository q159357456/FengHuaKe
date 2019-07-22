//
//  CookingTableViewCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/15.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingTableViewCell.h"
@interface CookingTableViewCell()
@property(nonatomic,strong)UIImageView * logo;
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)QMUIButton * btn;
@end
@implementation CookingTableViewCell

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
        self.btn = [[QMUIButton alloc]init];
        [self.contentView addSubview:self.btn];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(60*MULPITLE, 30*MULPITLE));
             make.top.mas_equalTo(self.contentView).offset(10*MULPITLE);
             make.right.mas_equalTo(self.contentView).offset(-10*MULPITLE);
        }];
        self.label1 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(self.logo.mas_right).offset(5*MULPITLE);
             make.right.mas_equalTo(self.btn.mas_left).offset(-5*MULPITLE);
             make.top.mas_equalTo(self.contentView).offset(10*MULPITLE);
             make.height.mas_equalTo(20*MULPITLE);
        }];
        CGFloat tempS = 10*MULPITLE;
        for (NSInteger i = 0; i<5; i++) {
            UIImageView * star = [[UIImageView alloc]init];
            star.tag = i+100;
            [self.contentView addSubview:star];
            [star mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(tempS, tempS));
                make.left.mas_equalTo(self.logo.mas_right).offset(5*MULPITLE + i*(tempS+2));
                make.top.mas_equalTo(self.label1.mas_bottom).offset(5*MULPITLE);
            }];
        }
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.label1.mas_bottom).offset(10*MULPITLE+tempS);
            make.left.mas_equalTo(self.logo.mas_right).offset(5*MULPITLE);
            make.size.mas_equalTo(CGSizeMake(300*MULPITLE, 20*MULPITLE));
        }];
        
        self.label1.font = ZWHFont(14*MULPITLE);
        self.label2.font = ZWHFont(14*MULPITLE);
        self.label2.textColor = [UIColor lightGrayColor];
    }
    return self;
}
-(void)loadData:(ShopModel*)model{
    
    ImageCacheDefine(self.logo, model.LogoUrl);
    self.label1.text = model.ShopName;
    self.label2.text = model.cityName;
    for (NSInteger i=0; i<5; i++) {
         NSInteger temp = 100+i;
        UIImageView * imageview = [self viewWithTag:temp];
        if (i>=model.grade)
        {
            imageview.image = [UIImage imageNamed:@"cooking_1"];
            
        }else
        {
            imageview.image = [UIImage imageNamed:@"cooking_2"];
        }
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
