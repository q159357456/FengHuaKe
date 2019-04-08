//
//  STShopCarTableViewCell.m
//  GBYouJiFenManager
//
//  Created by 工博计算机 on 17/9/8.
//  Copyright © 2017年 秦根. All rights reserved.
//

#import "STShopCarTableViewCell.h"

@implementation STShopCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(ShopCarModel *)model
{
    _model=model;
    self.product.text=model.proname;
    self.countLable.text=[NSString stringWithFormat:@"%@",model.nums];
    self.proCount.text=[NSString stringWithFormat:@"X%@",model.nums];
    [self.proImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:model.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    self.proSpc.text=[NSString stringWithFormat:@"价格:%@",model.saleprice1];
    if (model.isSelected) {
        self.selLable.backgroundColor=MainColor;
        
    }else
    {
        self.selLable.backgroundColor=[UIColor whiteColor];
    }
    
}

-(void)setSpecmodel:(ProductSpecModel *)specmodel{
    _specmodel=specmodel;
    self.product.text=_specmodel.descr;
    self.countLable.text=[NSString stringWithFormat:@"%@",_specmodel.nums];
    self.proCount.text=[NSString stringWithFormat:@"X%@",_specmodel.nums];
    [self.proImage sd_setImageWithURL:[NSURL URLWithString:[DataProcess PicAdress:_specmodel.url]] placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
    self.proSpc.text=[NSString stringWithFormat:@"价格:%@",_specmodel.saleprice1];
}

-(void)setSelLable:(UILabel *)selLable
{
    _selLable=selLable;
    _selLable.layer.cornerRadius=10;
    _selLable.layer.masksToBounds=YES;
    _selLable.layer.borderWidth=1;
    _selLable.layer.borderColor=[UIColor lightGrayColor].CGColor;
}
-(void)setHideen
{
    self.pluse.hidden=YES;
    self.mince.hidden=YES;
    self.countLable.hidden=YES;
    self.proCount.hidden=NO;
    self.deletButton.hidden=YES;
}
-(void)setNoHideen{
    self.pluse.hidden=NO;
    self.mince.hidden=NO;
    self.countLable.hidden=NO;
    self.proCount.hidden=YES;
    self.deletButton.hidden=NO;
}
- (IBAction)mince:(UIButton *)sender {
    if (self.minceBlock) {
         self.minceBlock();
    }
   
}
- (IBAction)pluse:(UIButton *)sender {
    if (self.pluseBlock) {
        self.pluseBlock();
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
