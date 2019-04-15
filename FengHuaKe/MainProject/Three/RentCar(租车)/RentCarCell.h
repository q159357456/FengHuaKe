//
//  RentCarCell.h
//  FengHuaKe
//
//  Created by chenheng on 2019/4/12.
//  Copyright © 2019年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RentCarModel;
@interface RentCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property(nonatomic,strong) RentCarModel *model;
@end

@interface RentCarModel : BaseModelObject
@property(nonatomic,copy)NSString* StatusText;
@property(nonatomic,copy)NSString* code;
@property(nonatomic,copy)NSString* createdate;
@property(nonatomic,copy)NSString* fristclass;
@property(nonatomic,copy)NSString* secondclass;
@property(nonatomic,copy)NSString* logonurl;
@property(nonatomic,copy)NSString* name ;
@property(nonatomic,copy)NSString* sex;
@property(nonatomic,copy)NSString* tips;
@property(nonatomic,assign)NSInteger  memberid;
@property(nonatomic,assign)NSInteger  evaluate_01;
@property(nonatomic,assign)NSInteger  evaluate_02;
@property(nonatomic,assign)NSInteger  evaluate_03;
@property(nonatomic,assign)NSInteger  evaluate_04;
@property(nonatomic,assign)NSInteger  evaluate_05;
@property(nonatomic,assign)NSInteger  quantity;
@property(nonatomic,assign)NSInteger ring_id;
@end
NS_ASSUME_NONNULL_END
