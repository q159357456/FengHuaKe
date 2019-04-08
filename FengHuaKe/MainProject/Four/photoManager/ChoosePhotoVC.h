//
//  ChoosePhotoVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/12.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeverPhotoManagerVC.h"
@interface ChoosePhotoVC : SeverPhotoManagerVC
@property(nonatomic,copy)void(^backBlock)(UIImage *coverImage,NSString*name,NSString *photoCode);
@end
