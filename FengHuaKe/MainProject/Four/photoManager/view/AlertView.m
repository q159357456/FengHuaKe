//
//  AlertView.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/11.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AlertView.h"
#define backColor [UIColor colorWithWhite:0 alpha:0.3]
@implementation AlertView

-(instancetype)initAltetViewWithBlock:(CretPhotoBlock)cretPhotoBlock
{
      AlertView *alerview=[[NSBundle mainBundle]loadNibNamed:@"AlertView" owner:nil options:nil][0];
    self=alerview;
    self.cretPhotoBlock=cretPhotoBlock;
    self.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor=backColor;
    _backView.layer.cornerRadius = WIDTH_PRO(8);
    _backView.layer.masksToBounds = YES;
    _doneButton.layer.cornerRadius = WIDTH_PRO(4);
    _doneButton.layer.masksToBounds = YES;
    _cancelButton.layer.cornerRadius = WIDTH_PRO(4);
    _cancelButton.layer.masksToBounds = YES;
    return self;
}

-(void)setDoneButton:(UIButton *)doneButton
{
    _doneButton=doneButton;
    _doneButton.backgroundColor=MainColor;
   
}
-(void)setCancelButton:(UIButton *)cancelButton
{
    _cancelButton=cancelButton;
    _cancelButton.backgroundColor=defaultColor1;
}
- (IBAction)done:(UIButton *)sender {

     self.cretPhotoBlock(_photoName.text,_photoDes.text,_publicSwich.on);
    [self removeFromSuperview];
}

- (IBAction)cancel:(UIButton *)sender {
  
    [self removeFromSuperview];
}

@end
