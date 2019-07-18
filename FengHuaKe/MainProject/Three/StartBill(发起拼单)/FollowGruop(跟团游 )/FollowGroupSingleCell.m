//
//  FollowGroupSingleCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "FollowGroupSingleCell.h"
@interface FollowGroupSingleCell()
@property(nonatomic,strong)UIImageView * imageV;
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@end
@implementation FollowGroupSingleCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo((SCREEN_WIDTH-30)/3);
        }];
        
        self.label1 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo((SCREEN_WIDTH-30)/12);
            make.top.mas_equalTo(self.imageV.mas_bottom);
        }];
        
        self.label2 = [[UILabel alloc]init];
        [self.contentView addSubview:self.label2];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo((SCREEN_WIDTH-30)/12);
            make.top.mas_equalTo(self.label1.mas_bottom);
        }];
        self.label1.font = ZWHFont(14);
        self.label2.font = ZWHFont(14);
        self.label2.textColor = [UIColor redColor];
        self.label2.textAlignment = NSTextAlignmentRight;
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
-(void)loadData:(ProductModel *)model
{
    ImageCacheDefine(self.imageV, model.url);
    self.label1.text = model.proname;
    self.label2.text = [NSString stringWithFormat:@"￥%.2f",[model.minPrice floatValue]];;
    
}
@end
