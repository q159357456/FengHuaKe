//
//  SeverPictureManagerVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/10.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoManagerModel.h"

@interface SeverPictureManagerVC : UICollectionViewController

@property(nonatomic,copy)NSString *code;

@property(nonatomic,strong)PhotoManagerModel *model;

@end
