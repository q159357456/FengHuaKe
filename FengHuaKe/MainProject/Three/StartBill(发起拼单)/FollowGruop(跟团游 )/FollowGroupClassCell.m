//
//  FollowGroupClassCell.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "FollowGroupClassCell.h"
@interface FollowGroupClassCell()
@property(nonatomic,strong)UIImageView * imageV;

@end
@implementation FollowGroupClassCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        self.label = [[UILabel alloc]init];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 18));
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(self.contentView).offset(10);
        }];
    }
    return self;
}

-(void)loadData:(TicketClassifyModel *)model
{
    ImageCacheDefine(self.imageV, model.icon);
}
@end
