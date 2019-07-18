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
@end

@implementation DoGroupBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    // Do any additional setup after loading the view.
}

-(void)setUI{
    
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scro];
    NSArray * array = @[self.ptitle,self.bigClassfy,self.orderNums,self.product,self.group_end_date,self.group_result,self.describ];
    UIView * last = nil;
    for (NSInteger i = 0; i<array.count; i++) {
        UIView * view = array[i];
        view.frame = CGRectMake(view.x,last?CGRectGetMaxY(last.frame):0 , view.width, view.height);
        [scro addSubview:view];
        last = view;
    }
    [scro setContentSize:CGSizeMake(scro.width, CGRectGetMaxY(last.frame))];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
