//
//  ListChooseView.h
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ListChooseViewDelegate <NSObject>
@optional
-(void)ListChooseViewCallBack:(NSString*)identifier Obj:(NSObject*)obj;

@end
@interface ListChooseView : UIView
@property(nonatomic,weak)id delegate;
+(instancetype)showListChoose:(CGRect)frame DataSource:(NSArray*)dataSource Identifier:(NSString*)identifier;
@end

NS_ASSUME_NONNULL_END
