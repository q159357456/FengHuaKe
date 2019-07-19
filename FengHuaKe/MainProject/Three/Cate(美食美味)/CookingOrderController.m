//
//  CookingOrderController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/16.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingOrderController.h"
#import "ZWHOrderModel.h"
#import "ZWHOrderPayViewController.h"
@interface CookingOrderController ()
@property(nonatomic,assign)NSInteger pcount;
@property(nonatomic,assign)NSInteger selctIndex;
@property(nonatomic,strong)UILabel * countLabel;
@property(nonatomic,strong)UILabel * totalLabel;
@property(nonatomic,strong)UILabel * bottomLabel;
@end

@implementation CookingOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pcount = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self bottomView];
    // Do any additional setup after loading the view.
}
-(void)setUI{
    UILabel * l_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    UILabel * l_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(l_1.frame), SCREEN_WIDTH, 40)];
    UIView * v_3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(l_1.frame), SCREEN_WIDTH, 40)];
    UILabel * l_4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(v_3.frame), SCREEN_WIDTH, 40)];
    UILabel * l_5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(l_4.frame), SCREEN_WIDTH, 40)];
    UILabel * l_6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(l_5.frame), SCREEN_WIDTH, 40)];
    UIView * v_7 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(l_6.frame), SCREEN_WIDTH, 50)];
    UIView * v_8 = [[UIView alloc]initWithFrame:CGRectMake(20*MULPITLE, CGRectGetMaxY(v_7.frame), SCREEN_WIDTH-40*MULPITLE, 60)];
    
    [self.view addSubview:l_1];
//    [self.view addSubview:l_2];
    [self.view addSubview:v_3];
    [self.view addSubview:l_4];
    [self.view addSubview:l_5];
    [self.view addSubview:l_6];
    [self.view addSubview:v_7];
    [self.view addSubview:v_8];
    
    l_1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    l_1.text = @"  订单详情";
//    l_2.text = [NSString stringWithFormat:@"  %@",@"测试"];
    
    UILabel * v3_label1 = [[UILabel alloc]init];
    UIButton * v3_btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel * v3_label2 = [[UILabel alloc]init];
    UIButton * v3_btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    v3_label1.frame = CGRectMake(0, 0, 200*MULPITLE, v_3.height);
    [v_3 addSubview:v3_label1];
    [v_3 addSubview:v3_btn1];
    [v_3 addSubview:v3_label2];
    [v_3 addSubview:v3_btn2];
    [v3_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(v_3);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(v_3).offset(-10);
    }];
    [v3_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(v_3);
        make.size.mas_equalTo(CGSizeMake(40, 30));
        make.right.mas_equalTo(v3_btn2.mas_left);
    }];
    [v3_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(v_3);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(v3_label2.mas_left);
    }];
    v3_label1.text = [NSString stringWithFormat:@"  %@",self.pmodel.proname];
    [v3_btn1 setTitle:@"-" forState:UIControlStateNormal];
    [v3_btn2 setTitle:@"+" forState:UIControlStateNormal];
    [v3_btn1 setBackgroundColor:MainColor];
    [v3_btn2 setBackgroundColor:MainColor];
    v3_label2.textAlignment = NSTextAlignmentCenter;
    v3_label2.font = ZWHFont(11);
    v3_label2.text = @"1";
    v3_label1.font = ZWHFont(13*MULPITLE);
    [v3_btn1 addTarget:self action:@selector(count:) forControlEvents:UIControlEventTouchUpInside];
    [v3_btn2 addTarget:self action:@selector(count:) forControlEvents:UIControlEventTouchUpInside];
    v3_btn1.tag = 30;
    v3_btn2.tag = 31;
    self.countLabel = v3_label2;
    l_4.textAlignment = NSTextAlignmentRight;
   
    l_4.text = [NSString stringWithFormat:@"￥%.2f  ",[self.pmodel.minPrice floatValue]];
    l_4.textColor = [UIColor redColor];
    self.totalLabel = l_4;
    l_5.textAlignment = NSTextAlignmentRight;
    l_5.text = @"选择优惠券>>     ";
    
    l_6.text = @"  用餐方式";
    l_6.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    v_8.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setBorder:l_1];
//    [self setBorder:l_2];
    [self setBorder:v_3];
    [self setBorder:l_4];
    l_1.font = ZWHFont(13*MULPITLE);
//    l_2.font = ZWHFont(13*MULPITLE);
    l_5.font = ZWHFont(13*MULPITLE);
    l_6.font = ZWHFont(13*MULPITLE);
    
    v3_btn1.layer.cornerRadius = 15;
    v3_btn2.layer.cornerRadius = 15;
    v3_btn1.layer.masksToBounds = YES;
    v3_btn2.layer.masksToBounds = YES;
    v_7.tag = 7;

    NSArray * temp = @[@"早餐",@"中餐",@"晚餐"];
    for (NSInteger i=0; i<3; i++) {
        QMUIButton * btn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, v_7.height);
        [btn setTitle:temp[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"slected_1"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"slected_2"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.tag = i+100;
        if (i == 1) {
            btn.selected = YES;
            self.selctIndex = btn.tag;
        }
        
        btn.imagePosition =  QMUIButtonImagePositionLeft;
        [v_7 addSubview:btn];
        [btn addTarget:self action:@selector(selet:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UILabel * v8_label = [[UILabel alloc]initWithFrame:CGRectInset(v_8.bounds, 10, 10)];
    [v_8 addSubview:v8_label];
    v8_label.font = ZWHFont(14*MULPITLE);
    v8_label.numberOfLines = 0;
//    v8_label.backgroundColor = [UIColor redColor];
    v8_label.text = @"到店食用,请到店后扫描桌台二维码,以便通知厨房做菜";
}
-(void)setBorder:(UIView*)view{
    view.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    view.qmui_borderWidth = 1;
    view.qmui_borderPosition = QMUIViewBorderPositionBottom;
}
-(void)bottomView{
    UIView * bottom = [[UIView alloc]init];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    UIView * view1 = [[UIView alloc]init];
    UIView * view2 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bottom addSubview:view1];
    [bottom addSubview:view2];

    
//    view1.backgroundColor = [UIColor whiteColor];
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
  
    UILabel * v1_label = [[UILabel alloc]init];
    [view1 addSubview:v1_label];
    [v1_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0 ));
    }];
    v1_label.font = ZWHFont(14);
    v1_label.textColor = [UIColor lightGrayColor];
    v1_label.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel = v1_label;
    [self setBottomLabelText:[NSString stringWithFormat:@"￥%.2f  ",[self.pmodel.minPrice floatValue]]];
    
}
-(void)selet:(UIButton*)btn{
//    NSInteger temp = btn.tag-100;
    if (btn.tag == self.selctIndex) {
        return;
    }
    btn.selected = YES;
    UIView * view = [self.view viewWithTag:7];
    UIButton *  old = [view viewWithTag:self.selctIndex];
    old.selected = NO;
    self.selctIndex = btn.tag;
}
-(void)count:(UIButton*)btn{
    
    if (btn.tag == 30)
    {
        if (self.pcount > 1) {
            self.pcount -- ;
        }
    }else
    {
        self.pcount++;
    }
    CGFloat t = [self.pmodel.minPrice floatValue] * self.pcount;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.pcount];
    self.totalLabel.text = [NSString stringWithFormat:@"￥%.2f",t];
    [self setBottomLabelText:self.totalLabel.text];
}

-(void)setBottomLabelText:(NSString*)txt{
    NSString * content = [NSString stringWithFormat:@"订单总价:%@",txt];
    NSRange range = [content rangeOfString:txt];
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:content];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [att addAttribute:NSFontAttributeName value:ZWHFont(18) range:range];
    self.bottomLabel.attributedText = att;
}

-(void)pay:(UIButton*)btn{
    if ([GroupBuyMananger singleton].isGroupStyle) {
        NSString * mark ;
        if (self.selctIndex-100 == 0) {
            mark = @"早";
        }else if (self.selctIndex-100 == 1)
        {
            mark = @"中";
        }else
        {
            mark = @"晚";
        }
        [GroupBuyMananger singleton].repast.commonArguments.shopid = self.pmodel.shopid;
        [GroupBuyMananger singleton].repast.commonArguments.prono = self.pmodel.productno;
        [GroupBuyMananger singleton].repast.groupBuyParams.intresult = [NSString stringWithFormat:@"%ld",self.pcount];
        [GroupBuyMananger singleton].repast.groupBuyParams.para4 = mark;
        [GroupBuyMananger singleton].repast.groupBuyParams.para9 = self.cmodel.code;
        
    }else
    {
        [self payOrder];
    }
  
    
    
}
-(void)payOrder{
    NSString * mark ;
    if (self.selctIndex-100 == 0) {
        mark = @"早";
    }else if (self.selctIndex-100 == 1)
    {
        mark = @"中";
    }else
    {
        mark = @"晚";
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:UniqUserID forKey:@"memberid"];
    [dict setValue:userType forKey:@"member_type"];
    [dict setValue:@"1" forKey:@"pay"];
    [dict setValue:@"repast" forKey:@"command"];
    [dict setValue:[NSNumber numberWithBool:false] forKey:@"cart"];
    [dict setValue:@"" forKey:@"address"];
    [dict setValue:mark forKey:@"remark"];
    if (self.pmodel.productno && self.cmodel.code) {
        NSArray *productArr = @[@{@"product":self.pmodel.productno,@"prospec":self.cmodel.code,@"nums":@(self.pcount)}];
        [dict setObject:productArr forKey:@"product"];
        DefineWeakSelf;
        [DataProcess requestDataWithURL:PO_Create RequestStr:GETRequestStr(@[dict], nil, nil, nil, nil) Result:^(id obj, id erro) {
            NSLog(@"obj===>%@",obj);
            NSLog(@"erro==>%@",erro);
            if (ReturnValue==1) {
                NSDictionary *dict = obj[@"DataList"][0];
                [ZWHOrderModel mj_objectClassInArray];
                ZWHOrderModel *model = [ZWHOrderModel mj_objectWithKeyValues:dict];
                ZWHOrderPayViewController *vc = [[ZWHOrderPayViewController alloc]init];
                vc.state = 8;
                vc.orderModelList = @[model];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                [self showHint:@"下单失败"];
            }
        }];
    }
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
