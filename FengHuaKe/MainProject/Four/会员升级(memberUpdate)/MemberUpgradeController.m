//
//  MemberUpgradeController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/6/24.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "MemberUpgradeController.h"
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String])
@interface MemberUpgradeController ()
@property(nonatomic,strong)NSArray * coverArray;
@property(nonatomic,strong)ServiceBaseModel * baseModel;
@end

@implementation MemberUpgradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSDictionary *dic = @{@"para1":UniqUserID,@"para2":MEMBERTYPE};
    DefineWeakSelf;
    [DataProcess requestDataWithURL:MemberLevel_Current RequestStr:GETRequestStr(nil, dic, nil,nil, nil) Result:^(id obj, id erro) {
//        NSLog(@"结果===>%@",obj);
       
        if (!erro) {
            weakSelf.baseModel =  [ServiceBaseModel mj_objectWithKeyValues:obj];
            NSDictionary * dic1 = [weakSelf.baseModel.sysmodel.para1 toDictionary];
            NSDictionary * dic2 = [weakSelf.baseModel.sysmodel.para2 toDictionary];
//             NSLog(@"dic1===>%@",dic1);
//             NSLog(@"dic2===>%@",dic2);
            
        }
    }];
    [self initSubViews];
    
    // Do any additional setup after loading the view.
}
-(NSArray *)coverArray
{
    if (!_coverArray) {
        _coverArray = @[@"memberUpgrade_1",@"memberUpgrade_2",@"memberUpgrade_3",@"memberUpgrade_4",@"memberUpgrade_5",@"memberUpgrade_6"];
    }
    return _coverArray;
}
-(void)initSubViews{
    UIView * topview = [[UIView alloc]init];
    UIView * middleView = [[UIView alloc]init];
    UIView * bottomView = [[UIView alloc]init];
    
    topview.backgroundColor = [UIColor whiteColor];
    middleView.backgroundColor = [UIColor whiteColor];
    bottomView.backgroundColor = [UIColor whiteColor];
   
    topview.frame = CGRectMake(0, 0, ScreenWidth, 100*MULPITLE);
    middleView.frame = CGRectMake(0, CGRectGetMaxY(topview.frame)+ 10, ScreenWidth, 93*MULPITLE);
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(middleView.frame)+10, ScreenWidth, 240*MULPITLE);
    
    [self.view addSubview:topview];
    [self.view addSubview:middleView];
    [self.view addSubview:bottomView];
    
    UIImageView * userImageView = [[UIImageView alloc]init];
    UILabel * label1 = [[UILabel alloc]init];
    UILabel * label2 = [[UILabel alloc]init];
    UILabel * label3 = [[UILabel alloc]init];
    [topview addSubview:userImageView];
    [topview addSubview:label1];
    [topview addSubview:label2];
    [topview addSubview:label3];
    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topview.mas_top).offset(10);
        make.left.mas_equalTo(topview.mas_left).offset(13);
        make.size.mas_equalTo(CGSizeMake(40*MULPITLE, 40*MULPITLE));
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(userImageView.mas_centerY);
        make.left.mas_equalTo(userImageView.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(topview.mas_right);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topview.mas_left).offset(103*MULPITLE);
        make.top.mas_equalTo(label1.mas_bottom).offset(5*MULPITLE);
        make.size.mas_equalTo(CGSizeMake(47*MULPITLE, 24*MULPITLE));
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label2.mas_right).offset(6*MULPITLE);
        make.top.mas_equalTo(label2.mas_top);
        make.size.mas_equalTo(CGSizeMake(80*MULPITLE, 24*MULPITLE));
    }];

    
    UIImageView * imageView = [[UIImageView alloc]init];
    [middleView addSubview:imageView];
    imageView.image = [UIImage imageNamed:self.coverArray[0]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    NSArray * titleArray = @[@"升级会员",@"PULS会员",@"升级代理人",@"升级门店",@"市级分公司",@"省级分公司"];
    NSArray * imageArray = @[@"升级会员",@"会员",@"代理人",@"门店",@"市级",@"省级"];
    CGFloat w = (ScreenWidth - 2)/3;
    CGFloat h = (240*MULPITLE - 1)/2;
    for (NSInteger i=0; i<6; i++) {
        CGFloat x = (i%3) * (w+1);
        CGFloat y = (i/3) * (h+1);
        QMUIButton * button = [[QMUIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//        button.backgroundColor = [UIColor yellowColor];
        button.spacingBetweenImageAndTitle = 10;
        button.titleLabel.font =[UIFont systemFontOfSize:14*MULPITLE];
        button.imagePosition =  QMUIButtonImagePositionTop;
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [bottomView addSubview:button];
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
