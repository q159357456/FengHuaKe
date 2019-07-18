//
//  StartTogetherBillController.m
//  FengHuaKe
//
//  Created by chenheng on 2019/7/17.
//  Copyright © 2019 gongbo. All rights reserved.
//

#import "StartTogetherBillController.h"
#import "GBSegmentView.h"
#import "TogetherFreeController.h"
#import "FollowGroupController.h"
@interface StartTogetherBillController ()
@property(nonatomic,strong)TogetherFreeController * togetherFreeController;
@property(nonatomic,strong)FollowGroupController * followGroupController;
@property(nonatomic,strong)UIScrollView * scroView;
@end

@implementation StartTogetherBillController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * title = @[@"拼单自由行",@"跟团游"];
    DefineWeakSelf;
    GBSegmentView * seg = [GBSegmentView initialSegmentViewFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 50) DataSource:title SegStyle:SegStyle_2 CallBack:^(NSInteger index) {
//        CashClassModel * model = weakSelf.classArr[index-1];
//        [weakSelf getListData:model];
        [weakSelf.scroView setContentOffset:CGPointMake((index-1)*SCREEN_WIDTH, 0) animated:YES];
        
    }];
    seg.qmui_borderColor = [UIColor groupTableViewBackgroundColor];
    seg.qmui_borderWidth = 1;
    seg.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [self.view addSubview:seg];
    
    UIScrollView * scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(seg.frame), SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-50)];
    [self.view addSubview:scro];
    
    self.togetherFreeController = [[TogetherFreeController alloc]init];
    self.togetherFreeController.view.frame = CGRectMake(0, 0, scro.width, scro.height);
    [scro addSubview:self.togetherFreeController.view];
    [self addChildViewController:self.togetherFreeController];
    
    
    self.followGroupController = [[FollowGroupController alloc]init];
    self.followGroupController.code = self.code;
    self.followGroupController.InsuranceCode = self.InsuranceCode;
    self.followGroupController.view.frame = CGRectMake(SCREEN_WIDTH, 0, scro.width, scro.height);
    [scro addSubview:self.followGroupController.view];
    [self addChildViewController:self.followGroupController];
    
    
    [scro setContentSize:CGSizeMake(SCREEN_WIDTH*2, scro.height)];
    
    scro.pagingEnabled = YES;
    
    self.scroView = scro;
    
    self.scroView.scrollEnabled = NO;
    
    // Do any additional setup after loading the view.
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
