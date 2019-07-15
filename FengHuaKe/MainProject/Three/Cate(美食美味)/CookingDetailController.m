//
//  CookingDetailController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/15.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingDetailController.h"

@interface CookingDetailController ()

@end

@implementation CookingDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}
-(void)setUI{
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100*MULPITLE)];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*MULPITLE)];
    
    UIView * view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180*MULPITLE)];
    
    UIView * tag1 = [self tagView:@"" Color:[UIColor redColor] Frame:CGRectMake(0, 0, SCREEN_WIDTH, 40*MULPITLE)];
    
    UIView * view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180*MULPITLE)];
    
    UIView * line = [self lineViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*MULPITLE)];
    
    UIView * tag2 = [self tagView:@"" Color:[UIColor redColor] Frame:CGRectMake(0, 0, SCREEN_WIDTH, 40*MULPITLE)];
    
    UIView * view5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180*MULPITLE)];
    
    UIView * line = [self lineViewFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*MULPITLE)];
    
    
    UIView * tag3 = [self tagView:@"" Color:[UIColor redColor] Frame:CGRectMake(0, 0, SCREEN_WIDTH, 40*MULPITLE)];
    
}

-(void)bottomView{
    UIView * bottom = [[UIView alloc]init];
    
}
-(UIView*)tagView:(NSString*)title Color:(UIColor*)color Frame:(CGRect)frame{
    
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
-(UIView*)lineViewFrame:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
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
