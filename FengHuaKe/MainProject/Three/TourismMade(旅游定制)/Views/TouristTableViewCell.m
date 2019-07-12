//
//  TouristTableViewCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/11.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "TouristTableViewCell.h"

@implementation TouristTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.headimageView = [[UIImageView alloc]init];
        self.contentimageView = [[UIImageView alloc]init];
        self.label1 = [[UILabel alloc]init];
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.headimageView];
        [self.contentView addSubview:self.contentimageView];
        [self.contentView addSubview:self.label1];
        [self.contentView addSubview:self.label2];
//        
//        self.label1.backgroundColor = [UIColor redColor];
//        self.label2.backgroundColor = [UIColor redColor];
//        self.headimageView.backgroundColor = [UIColor redColor];
//        self.contentimageView.backgroundColor = [UIColor redColor];
        self.label1.textColor = [UIColor lightGrayColor];
        self.label1.font = ZWHFont(13);
        self.label2.font = ZWHFont(14);
        
        self.headimageView.layer.cornerRadius = WIDTH_PRO(50)/2;
        self.headimageView.layer.masksToBounds = YES;
        [self.headimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WIDTH_PRO(40), WIDTH_PRO(40)));
            make.left.mas_equalTo(self).offset(10);
            make.top.mas_equalTo(self).offset(10);
        }];
        
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(WIDTH_PRO(200), WIDTH_PRO(20)));
            make.left.mas_equalTo(self.headimageView.mas_right).offset(10);
            make.bottom.mas_equalTo(self.headimageView);
        }];
        
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(10);
            make.top.mas_equalTo(self.label1.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, WIDTH_PRO(20)));
        }];
        
        [self.contentimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.label2.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, WIDTH_PRO(130)));
        }];
        
        
    }
    return self;
}
-(void)loadData:(BlogsModel *)model
{
    ImageCacheDefine(self.headimageView, model.logo);
    self.label1.text = [DataProcess resultTime:model.createdate];
    self.label2.text = model.title;
    ImageCacheDefine(self.contentimageView, model.img);
    
}
+(CGFloat)rowHeight{
    
    return 10+WIDTH_PRO(40)+10+WIDTH_PRO(20)+10+ WIDTH_PRO(130);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
