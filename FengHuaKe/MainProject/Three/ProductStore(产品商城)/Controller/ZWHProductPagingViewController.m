//
//  ZWHProductPagingViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/9/18.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHProductPagingViewController.h"
#import "ZWHProductListViewController.h"

@interface ZWHProductPagingViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentScrollView;

@end

@implementation ZWHProductPagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageView];
}



- (void)setupPageView {
    
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *childArr = [NSMutableArray array];
    for (ClassifyModel *model in _classArr){
        [titleArr addObject:model.name];
        ZWHProductListViewController *vc = [[ZWHProductListViewController alloc]init];
        vc.code = _code;
        vc.secode = model.code;
        
        //[self addChildViewController:vc];
        [childArr addObject:vc];
    }
    
    
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorAdditionalWidth = 10; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    configure.titleGradientEffect = YES;
    configure.titleSelectedColor = MAINCOLOR;
    configure.indicatorColor = MAINCOLOR;
    configure.bottomSeparatorColor = LINECOLOR;
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, ZWHNavHeight, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    
    /// pageContentScrollView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentScrollView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentScrollView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentScrollView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentScrollView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {

}


@end
