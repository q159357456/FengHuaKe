//
//  AdressManagerInputCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/5/14.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AdressManagerInputCell.h"

@implementation AdressManagerInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
     
        self.inputTextField=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lable.frame)+10, 4, ScreenWidth-30-self.lable.width, 35)];
        [self.contentView addSubview:self.inputTextField];
        self.inputTextField.textAlignment=NSTextAlignmentLeft;
        self.inputTextField.font=HTFont(30);
        self.inputTextField.delegate = self;
    }
    
    return self;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(_sureBlcok){
        _sureBlcok(self.inputTextField.text);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(_sureBlcok){
        _sureBlcok(self.inputTextField.text);
    }
    [self endEditing:YES];
    return NO;
}

-(void)didEndInput:(sureInputContent)input{
    _sureBlcok = input;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
