//
//  ZWHChooseBtnTableViewCell.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/30.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHChooseBtnTableViewCell.h"

@interface ZWHChooseBtnTableViewCell()

@property(nonatomic,strong)NSMutableArray *btnArray;


@end


@implementation ZWHChooseBtnTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _btnArray = [NSMutableArray array];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    _title = [[QMUILabel alloc]qmui_initWithFont:HTFont(28) textColor:[UIColor blackColor]];
    _title.text = @"服务类型";
    [self.contentView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(WIDTH_PRO(8));
    }];
}

-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    for(NSInteger i=0;i<titleArr.count;i++){
        QMUIButton *btn = [[QMUIButton alloc]init];
        btn.tag = i;
        [btn setTitleColor:ZWHCOLOR(@"AAAAAA") forState:0];
        [btn setTitle:titleArr[i] forState:0];
        [btn setImage:[UIImage imageNamed:@"picture_selet"] forState:0];
        [btn setImage:[UIImage imageNamed:@"picture_seleted"] forState:UIControlStateSelected];
        btn.titleLabel.font = HTFont(28);
        btn.imagePosition = QMUIButtonImagePositionLeft;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.spacingBetweenImageAndTitle = 3;
        btn.tag = i;
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WIDTH_PRO(8)*(i+1)+WIDTH_PRO(90)*i);
            make.width.mas_equalTo(WIDTH_PRO(90));
            make.height.mas_equalTo(HEIGHT_PRO(25));
            make.top.equalTo(_title.mas_bottom).offset(HEIGHT_PRO(6));
        }];
        [btn addTarget:self action:@selector(chooseTypeWith:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArray addObject:btn];
    }
}

-(void)chooseTypeWith:(QMUIButton *)btn{
    [self setSeleIndex:btn.tag];
    if (_returnIndex) {
        _returnIndex(btn.tag);
    }
}

-(void)setSeleIndex:(NSInteger)seleIndex{
    _seleIndex = seleIndex;
    for (QMUIButton *btn in _btnArray) {
        if (btn.tag == _seleIndex) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}



@end
