//
//  FreshViewController.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "FreshViewController.h"
#define requseSize 20
@interface FreshViewController ()

@end

@implementation FreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray=[NSMutableArray array];
    [self fresh];
    // Do any additional setup after loading the view.
}
-(NSInteger)startIndex
{
    if (!_startIndex) {
        _startIndex=1;
    }
    return _startIndex;
}

-(NSInteger)endIndex
{
    if (!_endIndex) {
        _endIndex=self.startIndex+requseSize;
    }
    return _endIndex;
}
-(void)fresh
{
    [self addHeaderRefresh];
    [self addFooterRefresh];
}
-(void)addHeaderRefresh
{
    DefineWeakSelf ;
    _header=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        //1.重置页数
        
        self.startIndex=1;
        self.endIndex=requseSize;
        
        //2.清空页数
        [_dataArray removeAllObjects];
        //3.重新发生网络请求
        [weakSelf headerFresh];
        
    }];
    [_header setTitle:@"努力刷新中" forState:MJRefreshStateRefreshing];
    
    
    
}
-(void)addFooterRefresh
{
    
    //上拉加载
    DefineWeakSelf;
    _footer=[MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        ;
        //1.页数增加
        self.startIndex=self.startIndex+requseSize;
        self.endIndex=self.startIndex+requseSize;
        
        //2.重新请求数据
        [weakSelf footFresh];
  
       
    }];
    [_footer setHidden:YES];
  
}


-(void)endFresh
{
    [_header endRefreshing];
    [_footer endRefreshing];
}

//没有更多数据
-(void)noModreData
{
     [_footer endRefreshingWithNoMoreData];
}
-(void)EndFreshWithArray:(NSArray *)resultArray
{
    [_footer setHidden:NO];
    if (self.startIndex==1)
    {
        [self endFresh];
        if (self.dataArray.count<requseSize) {
            [self noModreData];
        }
    }else
    {
        if (resultArray.count<requseSize)
        {
            [self noModreData];
        }else
        {
            [self endFresh];
        }
        
    }
   
}

-(void)headerFresh
{
    
}

-(void)footFresh
{
    
}


@end
