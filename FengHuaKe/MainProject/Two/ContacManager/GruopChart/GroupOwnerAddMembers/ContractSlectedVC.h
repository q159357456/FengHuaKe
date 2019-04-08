//
//  ContractSlectedVC.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContractSlectedVC;

@protocol SlectDelegate <NSObject>
-(void)selectArray:(NSMutableArray*)array;
@end
@interface ContractSlectedVC : UIViewController
@property(nonatomic,strong)NSMutableArray *exitArray;
@property(nonatomic,assign)id<SlectDelegate>delegate;
@property(nonatomic,assign)BOOL deletOrAdd;
@end
