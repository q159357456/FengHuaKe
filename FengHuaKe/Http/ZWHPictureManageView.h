//
//  ZWHPictureManageView.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^chooseImageHeightIsChnage)(CGFloat height);

@interface ZWHPictureManageView : UIView

@property (nonatomic,strong)chooseImageHeightIsChnage changeBclok;

/**
 * 初始化方法 num为最大选择数 rownum为每行最大数
 */
- (instancetype)initWithNum:(NSInteger)num withRowNum:(NSInteger)rownum;

//图片数据
@property(nonatomic,strong)NSMutableArray *pictureDataArr;

//图片URL数据
@property(nonatomic,strong)NSArray *pictureURLArr;



@end
