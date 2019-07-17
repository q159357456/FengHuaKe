//
//  CookingDetailController.m
//  FengHuaKe
//
//  Created by 秦根 on 2019/7/15.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "CookingDetailController.h"
#import "ProductModel.h"
#import "CookingDetailModel.h"
#import "CookingOrderController.h"
@interface CookingDetailController ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)ProductModel * pmodel;
@property(nonatomic,strong)CookingDetailModel * cmodel;
@property(nonatomic,strong)SDCycleScrollView *topScrView;
@property(nonatomic,strong)NSMutableArray * imgArr;
@property(nonatomic,strong)UILabel * countLabel;
@end

@implementation CookingDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.imgArr = [NSMutableArray array];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    DefineWeakSelf;
    NSDictionary * sysmodel = @{@"para1":self.proId,@"para2":UniqUserID,@"para3":MEMBERTYPE};
    [DataProcess requestDataWithURL:Cate_SinglePro RequestStr:GETRequestStr(nil, sysmodel, nil, nil, nil) Result:^(id obj, id erro) {
        NSLog(@"SingleProobj===>%@",obj);
        if (obj[@"DataList"]) {
            weakSelf.cmodel = [CookingDetailModel mj_objectWithKeyValues:obj[@"DataList"][0]];
            NSArray * array1 = (NSArray*)[HttpTool getDictWithData:obj[@"sysmodel"][@"para1"]];
            for (NSDictionary * dic in array1) {
                NSString * url = [NSString stringWithFormat:@"%@%@",SERVER_IMG,dic[@"url"]];
                [weakSelf.imgArr addObject:url];
            }
            weakSelf.pmodel = [ProductModel mj_objectWithKeyValues:[HttpTool getDictWithData:obj[@"sysmodel"][@"strresult"]]];
            [weakSelf setUI];
            [weakSelf bottomView];
            NSLog(@"array1==>%@",array1);
        }
       
    }];
    // Do any additional setup after loading the view.
}
-(SDCycleScrollView *)topScrView{
    if (!_topScrView) {
        NSArray *array = @[[UIImage imageNamed:@"ceshi_3_1"]];
        _topScrView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_PRO(161)) delegate:self placeholderImage:[UIImage imageNamed:PLACEHOLDER]];
        _topScrView.localizationImageNamesGroup = array;
        _topScrView.backgroundColor = [UIColor whiteColor];
        _topScrView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topScrView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _topScrView.pageControlBottomOffset = 5;
        _topScrView.pageControlDotSize = CGSizeMake(WIDTH_PRO(7.5), HEIGHT_PRO(7));
        _topScrView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _topScrView.currentPageDotColor = MAINCOLOR;
        _topScrView.pageDotColor = [UIColor whiteColor];
        _topScrView.autoScroll = YES;
    }
    return _topScrView;
}
-(void)setUI{
    UIScrollView * scroview = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroview];
    self.topScrView.imageURLStringsGroup = self.imgArr;
    [scroview addSubview:self.topScrView];
    
    CGFloat space = 10*MULPITLE;
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topScrView.frame), SCREEN_WIDTH, 100*MULPITLE)];
    UILabel * v1_label1 = [[UILabel alloc]initWithFrame:CGRectMake(space, space, 350*MULPITLE, 20*MULPITLE)];
    UILabel * v1_label2 = [[UILabel alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(v1_label1.frame)+5*MULPITLE, 80, 18)];
    UILabel * v1_label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(v1_label2.frame), v1_label2.y, 180, 18)];
    UILabel * v1_label4 = [[UILabel alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(v1_label2.frame)+5*MULPITLE, 180, 18)];
    UILabel * v1_label5 = [[UILabel alloc]initWithFrame:CGRectMake(space, CGRectGetMaxY(v1_label4.frame)+5*MULPITLE, 180, 18)];
    [view1 addSubview:v1_label1];
    [view1 addSubview:v1_label2];
    [view1 addSubview:v1_label3];
    [view1 addSubview:v1_label4];
    [view1 addSubview:v1_label5];
    [scroview addSubview:view1];
    [self setBorder:view1];
    v1_label1.font = ZWHFont(20);
    v1_label2.font = ZWHFont(16);
    v1_label3.font = ZWHFont(14);
    v1_label4.font = ZWHFont(13);
    v1_label5.font = ZWHFont(13);
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"会员价:￥%@",self.pmodel.minPrice]];
    NSRange range = [[NSString stringWithFormat:@"会员价:￥%@",self.pmodel.minPrice] rangeOfString:[NSString stringWithFormat:@"￥%@",self.pmodel.minPrice]];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [att addAttribute:NSFontAttributeName value:ZWHFont(18) range:range];
    v1_label1.text = self.pmodel.proname;
    v1_label2.text = [NSString stringWithFormat:@"￥%@",self.pmodel.maxPrice];
    v1_label3.attributedText = att;
    v1_label4.text = self.pmodel.brand;
    v1_label5.text = [NSString stringWithFormat:@"有效期:%@",self.pmodel.fitobject];

    v1_label2.textColor = [UIColor redColor];
    v1_label4.textColor = [UIColor lightGrayColor];
    v1_label5.textColor = [UIColor lightGrayColor];
    
    
    
    
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), SCREEN_WIDTH, 40*MULPITLE)];
    UILabel * v2_label = [[UILabel alloc]initWithFrame:CGRectMake(space, space, 100, 20*MULPITLE)];
    UIButton * v2_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    v2_btn.frame = CGRectMake(CGRectGetMaxX(v2_label.frame), space, 100, 20*MULPITLE);
    [view2 addSubview:v2_label];
    [view2 addSubview:v2_btn];
    [scroview addSubview:view2];
    [self setBorder:view2];
    v2_label.font = ZWHFont(14);
    v2_btn.titleLabel.font = ZWHFont(14);
    
    
    
    
    v2_btn.backgroundColor = MainColor;
    v2_label.text = @"选择套餐";
    [v2_btn setTitle:self.cmodel.spec forState:UIControlStateNormal];
    
    
    
    UIView * view3 = [[UIView alloc]init];
    UILabel * v3_label = [[UILabel alloc]init];
    v3_label.numberOfLines = 0;
    [view3 addSubview:v3_label];
    [scroview addSubview:view3];
    [self setBorder:view3];
    v3_label.font = ZWHFont(13*MULPITLE);
    NSString * str1 = [NSString stringWithFormat:@"茶位费:%@",self.cmodel.pcs];
    NSString * str2 = [NSString stringWithFormat:@"建议人数:%@",self.cmodel.saleweightunit];
    NSString * str3 = [NSString stringWithFormat:@"包间可用:%@",self.cmodel.spec];
    NSString * str4 = [NSString stringWithFormat:@"纸巾:%@",self.cmodel.color];
    NSString * total = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",str1,str2,str3,str4];
    NSMutableAttributedString * att1 = [[NSMutableAttributedString alloc]initWithString:total];
    NSMutableParagraphStyle *st = [[NSMutableParagraphStyle alloc]init];
    st.lineSpacing = 10*MULPITLE;
    [att1 addAttribute:NSParagraphStyleAttributeName value:st range:NSMakeRange(0, total.length)];
    v3_label.attributedText = att1;
    CGSize v3_size = [v3_label sizeThatFits:CGSizeMake(SCREEN_WIDTH-2*space, MAXFLOAT)];
    v3_label.frame = CGRectMake(space, space, SCREEN_WIDTH-2*space, v3_size.height);
    view3.frame = CGRectMake(0, CGRectGetMaxY(view2.frame), SCREEN_WIDTH, v3_label.height+2*space);

    
    
    UIView * tag1 = [self tagView:@"商品详情" Color:[UIColor redColor] Frame:CGRectMake(0, CGRectGetMaxY(view3.frame), SCREEN_WIDTH, 40*MULPITLE)];
    [scroview addSubview:tag1];
    [self setBorder:tag1];
    
    UIView * view4 = [[UIView alloc]init];
    UILabel * v4_label = [[UILabel alloc]init];
    [view4 addSubview:v4_label];
    [scroview addSubview:view4];
    [self setBorder:view4];
    v4_label.text = self.cmodel.property;
    v4_label.font = ZWHFont(15*MULPITLE);
    CGSize v4_size = [v4_label sizeThatFits:CGSizeMake(SCREEN_WIDTH-2*space, MAXFLOAT)];
    v4_label.frame = CGRectMake(space, space, SCREEN_WIDTH-2*space, v4_size.height);
    view4.frame = CGRectMake(0, CGRectGetMaxY(tag1.frame), SCREEN_WIDTH, v4_label.height+2*space);
    
    
    
    
    UIView * line = [self lineViewFrame:CGRectMake(0, CGRectGetMaxY(view4.frame), SCREEN_WIDTH, 10*MULPITLE)];
    [scroview addSubview:line];
    [self setBorder:line];
    
    UIView * tag2 = [self tagView:@"购买须知" Color:[UIColor redColor] Frame:CGRectMake(0, CGRectGetMaxY(line.frame), SCREEN_WIDTH, 40*MULPITLE)];
    [scroview addSubview:tag2];
    [self setBorder:tag2];
    
    UIView * view5 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tag2.frame), SCREEN_WIDTH, 180*MULPITLE)];
    UILabel * v5_label = [[UILabel alloc]init];
    [view5 addSubview:v5_label];
    [scroview addSubview:view5];
    [self setBorder:view5];
    v5_label.numberOfLines = 0;
//    v5_label.text = self.pmodel.remark;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
        NSData *data = [self.pmodel.remark dataUsingEncoding:NSUTF8StringEncoding];
        //设置富文本
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
        //设置段落格式
        NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
        para.lineSpacing = 7;
        para.paragraphSpacing = 10;
        [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
            v5_label.attributedText = attStr;
            CGSize v5_size = [v5_label sizeThatFits:CGSizeMake(SCREEN_WIDTH-2*space, MAXFLOAT)];
            v5_label.frame = CGRectMake(space, space, SCREEN_WIDTH-2*space, v5_size.height);
            view5.frame = CGRectMake(view5.x, view5.y, SCREEN_WIDTH, v5_label.height+2*space);
//            [scroview layoutIfNeeded];
//            [self.view layoutIfNeeded];
//        });
//    });

    
    UIView * line1 = [self lineViewFrame:CGRectMake(0,CGRectGetMaxY(view5.frame), SCREEN_WIDTH, 10*MULPITLE)];
    [scroview addSubview:line1];
    [self setBorder:line1];
    
    UIView * tag3 = [self tagView:@"商品评论" Color:[UIColor redColor] Frame:CGRectMake(0, CGRectGetMaxY(line1.frame), SCREEN_WIDTH, 40*MULPITLE)];
    [scroview addSubview:tag3];
    [self setBorder:tag3];
    
    [scroview setContentSize:CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(tag3.frame)+60*MULPITLE)];
    [self.view addSubview:scroview];
}

-(void)bottomView{
    UIView * bottom = [[UIView alloc]init];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    UIView * view1 = [[UIView alloc]init];
    UIView * view2 = [[UIView alloc]init];
    UIView * view3 = [[UIView alloc]init];
    [bottom addSubview:view1];
    [bottom addSubview:view2];
    [bottom addSubview:view3];
    
    view1.backgroundColor = [UIColor whiteColor];
    view2.backgroundColor = A_COLOR_STRING(0x4BA4FF, 0.9);
    view3.backgroundColor = MainColor;
    
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50*MULPITLE));
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 50*MULPITLE));
        make.left.mas_equalTo(bottom);
        make.bottom.mas_equalTo(bottom);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 50*MULPITLE));
        make.left.mas_equalTo(view1.mas_right);
        make.bottom.mas_equalTo(bottom);
        
    }];
    
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.left.mas_equalTo(view2.mas_right);
        make.bottom.mas_equalTo(bottom);
        make.right.mas_equalTo(bottom);
        make.top.mas_equalTo(bottom);
    }];
    
    UIButton *v1_btn = [[UIButton alloc]init];
//    v1_btn.backgroundColor = [UIColor redColor];
    [view1 addSubview:v1_btn];
    [v1_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view1);
        make.left.mas_equalTo(view1).offset(10*MULPITLE);
        make.size.mas_equalTo(CGSizeMake(30*MULPITLE, 30*MULPITLE));
    }];
    [v1_btn setImage:[UIImage imageNamed:@"cooking_1"] forState:UIControlStateNormal];
    [v1_btn setImage:[UIImage imageNamed:@"cooking_2"] forState:UIControlStateSelected];
    
    UIButton *v2_btn = [[UIButton alloc]init];
    [v2_btn setTitle:@"下单" forState:UIControlStateNormal];
    [view2 addSubview:v2_btn];
    [v2_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0 ));
    }];
    
    UIButton *v3_btn = [[UIButton alloc]init];
    [v3_btn setTitle:@"去支付" forState:UIControlStateNormal];
    [view3 addSubview:v3_btn];
    [v3_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0 ));
    }];
    
    [v1_btn addTarget:self action:@selector(collet:) forControlEvents:UIControlEventTouchUpInside];
    [v2_btn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [v3_btn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.font = ZWHFont(8*MULPITLE);
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.layer.cornerRadius = 9*MULPITLE;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.text = @"1";
    self.countLabel.backgroundColor = [UIColor redColor];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    [view2 addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18*MULPITLE, 18*MULPITLE));
        make.top.mas_equalTo(view2).offset(10*MULPITLE);
        make.left.mas_equalTo(view2).offset(SCREEN_WIDTH/6+20*MULPITLE);
    }];
    self.countLabel.hidden = YES;
}
-(void)collet:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showHint:@"收藏成功!"];
    }else
    {
        [self showHint:@"取消收藏成功!"];
    }
}
-(void)bill:(UIButton*)btn{
    self.countLabel.hidden = NO;
}
-(void)pay:(UIButton*)btn{
    CookingOrderController * order = [[CookingOrderController alloc]init];
    order.pmodel = self.pmodel;
    order.cmodel = self.cmodel;
    [self.navigationController pushViewController:order animated:YES];
}
-(UIView*)tagView:(NSString*)title Color:(UIColor*)color Frame:(CGRect)frame{
    
    UIView * view = [[UIView alloc]initWithFrame:frame];
    UIView * temp = [[UIView alloc]initWithFrame:CGRectMake(10*MULPITLE, 10*MULPITLE, 5*MULPITLE, 20*MULPITLE)];
    temp.backgroundColor = MainColor;
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(temp.frame)+10*MULPITLE, 0, 200*MULPITLE, frame.size.height)];
    label.text = title;
    label.font = ZWHFont(14*MULPITLE);
    [view addSubview:temp];
    [view addSubview:label];
    return view;
}
-(UIView*)lineViewFrame:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
-(void)setBorder:(UIView*)view{
    view.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    view.qmui_borderWidth = 1;
    view.qmui_borderPosition = QMUIViewBorderPositionBottom;
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
