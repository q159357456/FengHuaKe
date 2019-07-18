//
//  GroupByOrderController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/18.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "GroupByOrderController.h"
#import "GuidApplyTxtInputView.h"
#import "GuiApplyClickChoiceView.h"
#import "GuidApplyTextView.h"
@interface GroupByOrderController ()
@property(nonatomic,strong)GuidApplyTxtInputView * ptitle;
@property(nonatomic,strong)GuidApplyTxtInputView * orderNums;
@property(nonatomic,strong)GuidApplyTxtInputView *buyer;
@property(nonatomic,strong)GuidApplyTxtInputView *ruZhu_start;
@property(nonatomic,strong)GuidApplyTxtInputView *ruZhu_leave;
@property(nonatomic,strong)GuidApplyTxtInputView *ruZhu_end;
@property(nonatomic,strong)GuidApplyTextView *shuoMing;
@end

@implementation GroupByOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    //

    // Do any additional setup after loading the view.
}
-(void)setUI{
    
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scro];
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
    ImageCacheDefine(imageV, self.bmodel.url);
    [scro addSubview:imageV];
    GuidApplyBaseView * head = [[GuidApplyBaseView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), SCREEN_WIDTH, WIDTH_PRO(40))];
    head.label.text = self.bmodel.proname;
    [scro addSubview:head];
    NSArray * array = @[self.ptitle,self.orderNums,self.buyer,self.ruZhu_start,self.ruZhu_leave,self.ruZhu_end,self.shuoMing];
    UIView * last = head;
    for (NSInteger i = 0; i<array.count; i++) {
        UIView * view = array[i];
        view.frame = CGRectMake(view.x,CGRectGetMaxY(last.frame) , view.width, view.height);
        [scro addSubview:view];
        last = view;
    }
    [scro setContentSize:CGSizeMake(scro.width, CGRectGetMaxY(last.frame))];
    self.ptitle.textfield.text = self.bmodel.title;
    self.orderNums.textfield.text = [NSString stringWithFormat:@"%@",self.bmodel.nums];
    self.buyer.textfield.text = [NSString stringWithFormat:@"%@",self.bmodel.used_nums];
    self.ruZhu_start.textfield.text = [DataProcess resultTime:self.bmodel.start_use];
    self.ruZhu_leave.textfield.text = [DataProcess resultTime:self.bmodel.end_use];
    self.ruZhu_end.textfield.text = [DataProcess resultTime:self.bmodel.deadline];
    self.shuoMing.textview.text = self.bmodel.remark;
    
    
}
-(GuidApplyTxtInputView *)ptitle
{
    if (!_ptitle) {
        
        _ptitle = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        _ptitle.label.text = @"标题";
        _ptitle.not_edit_avilble = YES;
    }
    return _ptitle;
}

-(GuidApplyTxtInputView *)orderNums
{
    if (!_orderNums) {
        _orderNums = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        _orderNums.label.text = @"成单数";
        _orderNums.not_edit_avilble = YES;
    }
    return _orderNums;
}

-(GuidApplyTxtInputView *)buyer
{
    if (!_buyer) {
        _buyer = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        _buyer.label.text = @"已拼数量";
        _buyer.not_edit_avilble = YES;
    }
    return _buyer;
}

-(GuidApplyTxtInputView *)ruZhu_start
{
    if (!_ruZhu_start) {
        _ruZhu_start = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        _ruZhu_start.label.text = @"入住日期";
        _ruZhu_start.not_edit_avilble = YES;
    }
    return _ruZhu_start;
}

-(GuidApplyTxtInputView *)ruZhu_leave
{
    if (!_ruZhu_leave) {
        _ruZhu_leave = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        _ruZhu_leave.label.text = @"离店日期";
        _ruZhu_leave.not_edit_avilble = YES;
    }
    return _ruZhu_leave;
}

-(GuidApplyTxtInputView *)ruZhu_end
{
    if (!_ruZhu_end) {
        _ruZhu_end = [[GuidApplyTxtInputView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(40))];
        _ruZhu_end.label.text = @"截止日期";
        _ruZhu_end.not_edit_avilble = YES;
    }
    return _ruZhu_end;
}

-(GuidApplyTextView *)shuoMing
{
    if (!_shuoMing) {
        _shuoMing = [[GuidApplyTextView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, WIDTH_PRO(110))];
        _shuoMing.label.text = @"拼单说明";
        _shuoMing.not_edit_avilble = YES;
    }
    return _shuoMing;
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
