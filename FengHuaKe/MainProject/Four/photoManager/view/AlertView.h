//
//  AlertView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CretPhotoBlock) (NSString *name,NSString *des,NSInteger publish);
@interface AlertView : UIView
@property(nonatomic,copy)CretPhotoBlock cretPhotoBlock;
@property (weak, nonatomic) IBOutlet UITextField *photoName;
@property (weak, nonatomic) IBOutlet UITextField *photoDes;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwich;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *backView;


-(instancetype)initAltetViewWithBlock:(CretPhotoBlock)cretPhotoBlock;
@end
