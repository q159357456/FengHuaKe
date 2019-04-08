//
//  ImageLabel.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/3/28.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ImageLabel.h"
#import "Masonry.h"
@interface ImageLabel()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label;
@end
@implementation ImageLabel

+(instancetype)initWithFrame:(CGRect)frame Image:(NSString*)imageNmae Title:(NSString*)title IsNet:(BOOL)isNet;
{
    //设置默认值
    
    ImageLabel *imaagelable=[[self alloc]initWithFram:frame Image:imageNmae Title:title IsNet:isNet];
    return imaagelable;
}
-(instancetype)initWithFram:(CGRect)frame Image:(NSString*)imageNmae Title:(NSString*)title IsNet:(BOOL)isNet
{
    self=[super initWithFrame:frame];
    if (self) {
        _labelHeight=21;
        _imageHeight=40;
        _imageOffsetY=10;
        _labelOffsetY=6;
        _labelFont=[UIFont systemFontOfSize:12];
       
        // Label
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.font = _labelFont;
        label.userInteractionEnabled = NO;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.label = label;
        
        // ImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = NO;
        if (isNet) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:imageNmae]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        }else
        {
             imageView.image = [UIImage imageNamed:imageNmae];
        }
       
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(_imageHeight, _imageHeight));
        make.top.mas_equalTo(self.mas_top).offset(_imageOffsetY);
        make.centerX.mas_equalTo(self.mas_centerX);
        
    }];
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(_labelOffsetY);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(_labelHeight);
        
    }];
}
-(void)setImageHeight:(CGFloat)imageHeight
{
    
    _imageHeight=imageHeight;
    [self layoutSubviews];
}
-(void)setLabelHeight:(CGFloat)labelHeight
{
    _labelHeight=labelHeight;
    [self layoutSubviews];
}
-(void)setLabelOffsetY:(CGFloat)labelOffsetY
{
    _labelOffsetY=labelOffsetY;
    [self layoutSubviews];
}
-(void)setImageOffsetY:(CGFloat)imageOffsetY
{
    _imageOffsetY=imageOffsetY;
    [self layoutSubviews];
}
-(void)setLabelFont:(UIFont *)labelFont
{
    _labelFont=labelFont;
    self.label.font=_labelFont;
}
-(void)setLabelColor:(UIColor *)labelColor
{
    _labelColor=labelColor;
    self.label.textColor=_labelColor;
}
-(void)setNumberOfLines:(NSInteger)numberOfLines
{
    _numberOfLines=numberOfLines;
    self.label.numberOfLines=_numberOfLines;
}
-(void)setTextAlign:(NSTextAlignment)textAlign
{
    _textAlign=textAlign;
    self.label.textAlignment=_textAlign;
}
-(void)setLabelBacgroudColor:(UIColor *)labelBacgroudColor
{
    _labelBacgroudColor=labelBacgroudColor;
    self.labelBacgroudColor=labelBacgroudColor;
}
-(void)setContentMode:(UIViewContentMode)contentMode
{
    _contentMode=contentMode;
    _imageView.contentMode=contentMode;
}
@end
