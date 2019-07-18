//
//  DoGroupBuyController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "DoGroupBuyController.h"
#import "GuidApplyTxtInputView.h"
#import "GuiApplyClickChoiceView.h"
@interface DoGroupBuyController ()
//标题
@property(nonatomic,strong)GuidApplyTxtInputView * ptitle;
//产品大类
@property(nonatomic,strong)GuiApplyClickChoiceView * bigClassfy;
//成单数
@property(nonatomic,strong)GuidApplyTxtInputView * orderNums;
//产品
@property(nonatomic,strong)GuiApplyClickChoiceView * product;
//拼单结束日期
@property(nonatomic,strong)GuidApplyTxtInputView * group_end_date;
//拼单失败是否保留
@property(nonatomic,strong)GuidApplyTxtInputView * group_result;
//文字介绍
@property(nonatomic,strong)GuidApplyTxtInputView * describ;

/*门票*/
//使用日期
@property(nonatomic,strong)GuiApplyClickChoiceView * use_date;

/*酒店*/
@property(nonatomic,strong)GuiApplyClickChoiceView * live_date;
@property(nonatomic,strong)GuiApplyClickChoiceView * left_date;

/*旅游城市特产*/
@property(nonatomic,strong)GuiApplyClickChoiceView * shipping_addres;

/*美食美味*/
@property(nonatomic,strong)GuiApplyClickChoiceView * use_Time;
//@property(nonatomic,strong)GuidApplyTxtInputView * use_date;

/*美食美味*/
//@property(nonatomic,strong)GuidApplyTxtInputView * shipping_addres;
@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation DoGroupBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titles = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.group_end_date,self.group_result,self.describ];
    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)setUI{
    
    UIView * last = nil;
    for (NSInteger i = 0; i<self.titles.count; i++) {
        UIView * view = self.titles[i];
        view.frame = CGRectMake(view.x,last?CGRectGetMaxY(last.frame):0 , view.width, view.height);
        if (![self.scro.subviews containsObject:view])
        {
             [self.scro addSubview:view];
        }
       
        last = view;
    }
    [self.scro setContentSize:CGSizeMake(self.scro.width, CGRectGetMaxY(last.frame))];
}


-(UIScrollView *)scro
{
    if (!_scro) {
        _scro = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_scro];
    }
    return _scro;
}
-(GuidApplyTxtInputView *)ptitle
{
    if (!_ptitle) {
        _ptitle = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //标题
        _ptitle.label.text = @"标题";
    }
    return _ptitle;
}

-(GuiApplyClickChoiceView *)bigClassfy
{
    if (!_bigClassfy) {
        _bigClassfy = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品大类
        _bigClassfy.label.text = @"产品大类";
    }
    return _bigClassfy;
}

-(GuidApplyTxtInputView *)orderNums
{
    if (!_orderNums) {
        _orderNums = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //成单数
        _orderNums.label.text = @"成单数";
    }
    return _orderNums;
}

-(GuiApplyClickChoiceView *)product
{
    if (!_product) {
        _product = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品
        _product.label.text = @"产品";
    }
    return _product;
}

-(GuidApplyTxtInputView *)group_end_date
{
    if (!_group_end_date) {
        _group_end_date = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //拼单结束日期
        _group_end_date.label.text = @"拼单结束日期";
    }
    return _group_end_date;
}

-(GuidApplyTxtInputView *)describ
{
    if (!_describ) {
        _describ = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //文字介绍
        _describ.label.text = @"文字介绍";
    }
    return _describ;
}

-(GuidApplyTxtInputView *)group_result
{
    if (!_group_result) {
        _group_result = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //拼单失败是否保留
        _group_result.label.text = @"拼单失败是否保留";
    }
    return _group_result;
}

-(GuiApplyClickChoiceView *)use_date
{
    if (!_use_date) {
        _use_date = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品
        _use_date.label.text = @"产品";
    }
    return _use_date;
}

-(GuiApplyClickChoiceView *)live_date
{
    if (!_live_date) {
        _live_date = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品
        _live_date.label.text = @"产品";
    }
    return _live_date;
}

-(GuiApplyClickChoiceView *)left_date
{
    if (!_left_date) {
        _left_date = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品
        _left_date.label.text = @"产品";
    }
    return _left_date;
}

-(GuiApplyClickChoiceView *)shipping_addres
{
    if (!_shipping_addres) {
        _shipping_addres = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品
        _shipping_addres.label.text = @"产品";
    }
    return _shipping_addres;
}

-(GuiApplyClickChoiceView *)use_Time
{
    if (!_use_Time) {
        _use_Time = [[GuiApplyClickChoiceView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        //产品
        _use_Time.label.text = @"产品";
    }
    return _use_Time;
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
