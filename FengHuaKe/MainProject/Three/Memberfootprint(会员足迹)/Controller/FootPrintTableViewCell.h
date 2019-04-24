//
//  FootPrintTableViewCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/4/23.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FootPtintModel;
@class FootPtintSearchModel;
NS_ASSUME_NONNULL_BEGIN
@interface FootPrintTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property(nonatomic,strong)FootPtintSearchModel *model;

@end

@interface FootPtintModel : BaseModelObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *parentid;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,assign)NSInteger memberuse;
@end


@interface FootPtintSearchModel : BaseModelObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *registerdate;
@property(nonatomic,copy)NSString *scale;
@property(nonatomic,copy)NSString *logo;
@end
NS_ASSUME_NONNULL_END
