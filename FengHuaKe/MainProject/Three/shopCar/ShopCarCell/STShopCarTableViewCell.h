//
//  STShopCarTableViewCell.h
//  GBYouJiFenManager
//
//  Created by 工博计算机 on 17/9/8.
//  Copyright © 2017年 秦根. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"
#import "ProductDetailModel.h"

@interface STShopCarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *selLable;
@property (strong, nonatomic) IBOutlet UIImageView *proImage;
@property (strong, nonatomic) IBOutlet UILabel *product;
@property (strong, nonatomic) IBOutlet UILabel *proSpc;
@property (strong, nonatomic) IBOutlet UILabel *proCount;
@property (weak, nonatomic) IBOutlet UIButton *deletButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (strong, nonatomic) IBOutlet UIButton *pluse;
@property (strong, nonatomic) IBOutlet UIButton *mince;
@property (strong, nonatomic) IBOutlet UILabel *countLable;

@property(nonatomic,strong)ShopCarModel *model;

@property(nonatomic,strong)ProductSpecModel *specmodel;

@property(nonatomic,copy)void(^pluseBlock)();
@property(nonatomic,copy)void(^minceBlock)();
-(void)setHideen;
-(void)setNoHideen;
@end
