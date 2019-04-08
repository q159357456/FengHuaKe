//
//  AdressListVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreshViewController.h"
#import "AdressListModel.h"


@protocol AdressListVCDelegate <NSObject>

-(void)didSelectreturnModel:(AdressListModel *)model;

@end

@interface AdressListVC : FreshViewController

 @property(nonatomic,weak)id<AdressListVCDelegate> delegate;

@end
