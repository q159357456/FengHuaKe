//
//  CookingOrderController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingOrderController.h"

@interface CookingOrderController ()

@end

@implementation CookingOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self bottomView];
    // Do any additional setup after loading the view.
}
-(void)setUI{
    UILabel * l_1 = [[UILabel alloc]init];
    UILabel * l_2 = [[UILabel alloc]init];
    UIView * v_3 = [[UILabel alloc]init];
    UILabel * l_4 = [[UILabel alloc]init];
    UILabel * l_5 = [[UILabel alloc]init];
    UILabel * l_6 = [[UILabel alloc]init];
    UIView * v_7 = [[UILabel alloc]init];
    UIView * v_8 = [[UILabel alloc]init];
    
    [self.view addSubview:l_1];
    [self.view addSubview:l_2];
    [self.view addSubview:v_3];
    [self.view addSubview:l_4];
    [self.view addSubview:l_5];
    [self.view addSubview:l_6];
    [self.view addSubview:v_7];
    [self.view addSubview:v_8];
}

-(void)bottomView{
    UIView * bottom = [[UIView alloc]init];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    UIView * view1 = [[UIView alloc]init];
    UIView * view2 = [[UIView alloc]init];
;
    [bottom addSubview:view1];
    [bottom addSubview:view2];

    
    view1.backgroundColor = [UIColor whiteColor];
    view2.backgroundColor =MAINCOLOR;
  
    
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50*MULPITLE));
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 50*MULPITLE));
        make.left.mas_equalTo(bottom);
        make.bottom.mas_equalTo(bottom);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 50*MULPITLE));
        make.left.mas_equalTo(view1.mas_right);
        make.bottom.mas_equalTo(bottom);
        
    }];
    
 
    
   
    
    UIButton *v2_btn = [[UIButton alloc]init];
    [v2_btn setTitle:@"选好了" forState:UIControlStateNormal];
    [view2 addSubview:v2_btn];
    [v2_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0 ));
    }];
     
    
  
    [v2_btn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
  
    
    
}
-(void)pay:(UIButton*)btn{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
