//
//  ZWHInvoiceTableViewCell.h
//  FengHuaKe
//
//  Created by Syrena on 2018/8/6.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWHInvoiceModel.h"


@interface ZWHInvoiceTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *canpanyName;
@property(nonatomic,strong)UILabel *adresspanyName;

@property(nonatomic,strong)QMUIButton *setdefaultB;
@property(nonatomic,strong)QMUIButton *editB;
@property(nonatomic,strong)QMUIButton *deleteB;

@property(nonatomic,strong)ZWHInvoiceModel *model;


@end
