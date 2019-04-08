//
//  ProductChooseView.h
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"
#import "BuyCountView.h"
#import "ProductDetailModel.h"
typedef enum {
  ChoosingMode=0,
  AddShopCarMode=1,
  GoToPayMode
    
}ChooseStyle;
@protocol ProductChooseViewDelegate <NSObject>
@optional
-(void)DidChosenProducct:(ProductSpecModel*)model;
@end
@interface ProductChooseView : UIView<UITextFieldDelegate,UIAlertViewDelegate,TypeSeleteDelegete>
@property(nonatomic,assign)id<ProductChooseViewDelegate>proChoseDelegate;
@property(nonatomic, retain)UIView *alphaiView;
@property(nonatomic, retain)UIView *whiteView;

@property(nonatomic, retain)UIImageView *img;

@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain)TypeView *sizeView;
@property(nonatomic, retain)TypeView *colorView;
@property(nonatomic, retain)TypeView *modelView;
@property(nonatomic, retain)BuyCountView *countView;
@property(nonatomic, retain)UIButton *bt_sure;
@property(nonatomic, retain)UIButton *bt_cancle;
@property(nonatomic, retain)UIButton *bt_addshopCar;
@property(nonatomic, retain)UIButton *bt_goPay;
@property(nonatomic) int stock;
@property(nonatomic,strong)ProductDetailModel *productDetailModel;
@property(nonatomic,strong)NSMutableArray *SpecList;
@property(nonatomic,strong)NSMutableArray *ColorList;
@property(nonatomic,strong)NSMutableArray *ModelList;
@property(nonatomic,copy)NSString *chooseProduct;

@property(nonatomic,assign)ChooseStyle chooseStyle;
-(instancetype)initWithFrame:(CGRect)frame Style:(ChooseStyle)chooseStyle;
-(void)initViewWith:(ProductDetailModel*)model;
@end
