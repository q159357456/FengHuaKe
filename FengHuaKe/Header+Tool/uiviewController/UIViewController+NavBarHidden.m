//
//  UIViewController+NavBarHidden.m
//  FengHuaKe
//
//  Created by 秦根 on 2018/4/19.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "UIViewController+NavBarHidden.h"
#import "ProductDetailView.h"
#import <objc/runtime.h>
@interface UIViewController()
@property (nonatomic,strong) UIImage  * navBarBackgroundImage;
@end
@implementation UIViewController (NavBarHidden)
#pragma mark - 通过运行时动态添加存储属性
//定义关联的Key
static const char * key = "keyScrollView";

- (UIScrollView *)keyScrollView{
    
    return objc_getAssociatedObject(self, key);
}



- (void)setKeyScrollView:(UIScrollView *)keyScrollView{
    objc_setAssociatedObject(self, key, keyScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//定义关联的Key
static const char * keytableview = "keyTableView";

-(UITableView *)keyTableView{
    return objc_getAssociatedObject(self, keytableview);
}


-(void)setKeyTableView:(UITableView *)keyTableView{
    objc_setAssociatedObject(self, keytableview, keyTableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([keyTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        keyTableView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            keyTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            keyTableView.estimatedRowHeight = 0;
            keyTableView.estimatedSectionHeaderHeight = 0;
            keyTableView.estimatedSectionFooterHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

//定义关联的Key
static const char * keyollectionview = "keyCollectionView";
-(UICollectionView *)keyCollectionView{
    return objc_getAssociatedObject(self, keyollectionview);
}

-(void)setKeyCollectionView:(UICollectionView *)keyCollectionView{
    objc_setAssociatedObject(self, keyollectionview, keyCollectionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([keyCollectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            keyCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

//定义关联的Key
static const char * navBarBackgroundImageKey = "navBarBackgroundImage";
- (UIImage *)navBarBackgroundImage{
    return objc_getAssociatedObject(self, navBarBackgroundImageKey);
}

- (void)setNavBarBackgroundImage:(UIImage *)navBarBackgroundImage{
    objc_setAssociatedObject(self, navBarBackgroundImageKey, navBarBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 核心代码-即对外接口功能实现代码

static CGFloat alpha = 0;
//透明度

- (void)scrollControlByOffsetY:(CGFloat)offsetY{
    
    if ([self getScrollerView]){
        
        UIScrollView * scrollerView = [self getScrollerView];
        alpha =  scrollerView.contentOffset.y/offsetY;
        
    }else{
        return;
    }
    
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
//    NSLog(@"alpha:%f",alpha);
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:alpha];
    if (!self.overlay) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.bounds), CGRectGetHeight(self.self.navigationController.navigationBar.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;    // Should not set `UIViewAutoresizingFlexibleHeight`
        [[self.navigationController.navigationBar.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = color;
   

}

- (void)setInViewWillAppear{

    //设置导航栏透明
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

}
- (void)setInViewWillDisappear{

    //[[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];
    //UIColor *color = [[UIColor alloc]initWithRed:75/255.0f green:164/255.0f blue:255/255.0f alpha:1];
    [self.navigationController.navigationBar setBackgroundImage:[DataProcess barImage] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
}



#pragma mark - 内部方法

// 获取tableView 或者 collectionView

- (UIScrollView *)getScrollerView{
    
    if ([self isKindOfClass:[UITableViewController class]]) {
        return  (UIScrollView *)self.view;
    }else if ([self isKindOfClass:[UICollectionViewController class]]){
        return  (UIScrollView *)self.view;
    }else{
        
        for (UIView * view in self.view.subviews) {

            if ([view isEqual:self.keyScrollView] & [view isKindOfClass:[UIScrollView class]]||[view isEqual:self.keyScrollView] & [view isKindOfClass:[ProductDetailView class]]||[view isKindOfClass:[UITableView class]]) {
                return (UIScrollView *)view;
            }
        }
    }
    return nil;
}


@end
