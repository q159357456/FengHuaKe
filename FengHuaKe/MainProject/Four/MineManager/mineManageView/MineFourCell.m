//
//  MineFourCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/29.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "MineFourCell.h"
#import "ImageLabel.h"
#import "Masonry.h"
@implementation MineFourCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}
-(void)setUIWithArray:(NSArray*)array
{
    
    NSArray *imageArray=array[1];
    NSArray *titleArray=array[0];
    CGFloat  rowHeight;
    if (imageArray.count>4) {
        rowHeight=200;
        //rowHeight=100;
    }else
    {
        rowHeight=100;
    }
    NSInteger lineCount;
    if (imageArray.count%4==0) {
        lineCount = ceil(imageArray.count/4);
    }else{
        lineCount=ceil(imageArray.count/4+1);
    }
    for (NSInteger i=0; i<imageArray.count; i++) {

        CGFloat x=(i%4)*(ScreenWidth)/4;
        CGFloat y=(i/4)*rowHeight/2;
        CGFloat w=ScreenWidth/4;
        CGFloat h=rowHeight/lineCount;
        ImageLabel *imalable=[ImageLabel initWithFrame:CGRectZero Image:imageArray[i] Title:titleArray[i] IsNet:NO];
        [self addSubview:imalable];
        [imalable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(x);
            make.top.mas_equalTo(self.mas_top).offset(y);
            make.width.mas_equalTo(w);
            make.height.mas_equalTo(h);
            //make.height.mas_equalTo(60);
        }];
        imalable.labelOffsetY=6;
        imalable.tag=i+1;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        imalable.userInteractionEnabled=YES;
        [imalable addGestureRecognizer:tap];

        if (_isDouble) {
            switch (i) {
                case 0:
                    {
                        _eCoupon = [[UILabel alloc]init];
                        _eCoupon.text = @"-";
                        _eCoupon.textColor = ZWHCOLOR(@"#4BA4FF");
                        _eCoupon.font = HTFont(24);
                        _eCoupon.backgroundColor = ZWHCOLOR(@"#DEDEDE");
                        _eCoupon.textAlignment = NSTextAlignmentCenter;
                        [imalable addSubview:_eCoupon];
                        [_eCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.bottom.equalTo(imalable.mas_bottom).offset(-5);
                            make.centerX.equalTo(imalable);
                            make.height.mas_equalTo(16);
                            make.width.mas_equalTo(w*0.6);
                        }];
                        _eCoupon.layer.cornerRadius = 6;
                        _eCoupon.layer.masksToBounds = YES;
                    }
                    break;
                case 1:
                {
                    _cash = [[UILabel alloc]init];
                    _cash.text = @"-";
                    _cash.textColor = ZWHCOLOR(@"#4BA4FF");
                    _cash.font = HTFont(24);
                    _cash.backgroundColor = ZWHCOLOR(@"#DEDEDE");
                    _cash.textAlignment = NSTextAlignmentCenter;
                    [imalable addSubview:_cash];
                    [_cash mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(imalable.mas_bottom).offset(-5);
                        make.centerX.equalTo(imalable);
                        make.height.mas_equalTo(16);
                        make.width.mas_equalTo(w*0.6);
                    }];
                    _cash.layer.cornerRadius = 6;
                    _cash.layer.masksToBounds = YES;
                }
                    break;
                case 2:
                {
                    _brokerage = [[UILabel alloc]init];
                    _brokerage.text = @"-";
                    _brokerage.textColor = ZWHCOLOR(@"#4BA4FF");
                    _brokerage.font = HTFont(24);
                    _brokerage.backgroundColor = ZWHCOLOR(@"#DEDEDE");
                    _brokerage.textAlignment = NSTextAlignmentCenter;
                    [imalable addSubview:_brokerage];
                    [_brokerage mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(imalable.mas_bottom).offset(-5);
                        make.centerX.equalTo(imalable);
                        make.height.mas_equalTo(16);
                        make.width.mas_equalTo(w*0.6);
                    }];
                    _brokerage.layer.cornerRadius = 6;
                    _brokerage.layer.masksToBounds = YES;
                   
                }
                    break;
                case 3:
                {
                    _integral = [[UILabel alloc]init];
                    _integral.text = @"-";
                    _integral.textColor = ZWHCOLOR(@"#4BA4FF");
                    _integral.font = HTFont(24);
                    _integral.backgroundColor = ZWHCOLOR(@"#DEDEDE");
                    _integral.textAlignment = NSTextAlignmentCenter;
                    [imalable addSubview:_integral];
                    [_integral mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(imalable.mas_bottom).offset(-5);
                        make.centerX.equalTo(imalable);
                        make.height.mas_equalTo(16);
                        make.width.mas_equalTo(w*0.6);
                    }];
                    _integral.layer.cornerRadius = 6;
                    _integral.layer.masksToBounds = YES;
                }
                    break;
                default:
                    break;
            }
            
        }
    }
}
-(void)click:(UIGestureRecognizer*)tap
{
    NSInteger k=tap.view.tag;
    if (self.funBlock) {
        self.funBlock([NSNumber numberWithInteger:k]);
    }
}

-(void)setIsDouble:(BOOL)isDouble{
    _isDouble = isDouble;
    [self setUIWithArray:_dataArray];
}

-(void)updateCellWithData:(id)data
{
    NSArray *array=(NSArray*)data;
    _dataArray = array;
    //[self setUIWithArray:_dataArray];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
