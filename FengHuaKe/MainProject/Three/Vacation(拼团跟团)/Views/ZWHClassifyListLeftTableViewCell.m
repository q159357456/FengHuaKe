//
//  ZWHClassifyListLeftTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/27.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHClassifyListLeftTableViewCell.h"

@implementation ZWHClassifyListLeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.textLabel.textColor = selected?MAINCOLOR:[UIColor qmui_colorWithHexString:@"808080"];
    self.backgroundColor = selected?[UIColor whiteColor]:ZWHCOLOR(@"F0F0F0");
}


-(void)setUI{
    self.textLabel.font = HTFont(28);
    self.textLabel.textColor = [UIColor qmui_colorWithHexString:@"808080"];
    self.backgroundColor = ZWHCOLOR(@"F0F0F0");
}

@end
