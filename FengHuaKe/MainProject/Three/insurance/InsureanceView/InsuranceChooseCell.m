//
//  InsuranceChooseCell.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/6/23.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "InsuranceChooseCell.h"
#import "InsuraceChooseBtn.h"
@implementation InsuranceChooseCell
{
    NSInteger slectInex;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSArray *array=@[@"国内游",@"境外游"];
        for (NSInteger i=0; i<array.count; i++) {
            InsuraceChooseBtn *button=[[InsuraceChooseBtn alloc]initWithFrame:CGRectMake(i*ScreenWidth/2, 0,ScreenWidth/2, 39)];
            [button setTitle:array[i] forState:UIControlStateNormal];

            button.tag=i+1;
            
            if (i==0) {
                button.selected=YES;
                slectInex=button.tag;
                
            }
            [button addTarget:self action:@selector(chooseModel:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:button];
            
        }
        
        
    }
    return self;
}
-(void)chooseModel:(UIButton*)butt
{
    if (butt.tag==slectInex) {
        
        return;
    }
    
    UIButton *button=(UIButton*)[self viewWithTag:slectInex];
    button.selected=NO;
    //
    butt.selected=YES;
    slectInex=butt.tag;
    
    if (self.chooseModelBlock) {
        self.chooseModelBlock(slectInex);
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
