//
//  FreshViewController.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreshViewController : UIViewController
@property(nonatomic,strong)MJRefreshAutoGifFooter *footer;
@property(nonatomic,strong)MJRefreshGifHeader *header;
@property(nonatomic,assign)NSInteger startIndex;
@property(nonatomic,assign)NSInteger endIndex;
@property(nonatomic,strong)NSMutableArray *dataArray;
-(void)headerFresh;
-(void)footFresh;
-(void)EndFreshWithArray:(NSArray*)resultArray;

@end
