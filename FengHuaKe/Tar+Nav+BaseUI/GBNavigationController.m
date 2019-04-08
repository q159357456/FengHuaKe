//
//  GBNavigationController.m
//  Restaurant
//
//  Created by 张帆 on 16/9/28.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import "GBNavigationController.h"

@interface GBNavigationController ()

@end

@implementation GBNavigationController
+ (void)initialize {
    //设置bar背景
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundColor:[UIColor clearColor]];
    [navBar setBackgroundImage:[DataProcess barImage]  forBarMetrics:UIBarMetricsDefault];
    navBar.shadowImage = [[UIImage alloc] init];
//    [navBar setBackgroundImage:[DataProcess barImage] forBarMetrics:UIBarMetricsDefault];

//
//   [navBar setBarTintColor:[UIColor clearColor]];
    //设置文字样式
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    attrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    attrs[NSFontAttributeName] = HTFont(28);
    [navBar setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    
   
    if (self.viewControllers.count > 0) {//除了根视图控制器以外的所有控制，以压栈的方式push进来，就隐藏tabbar
        
        //导航栏返回手势
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
        [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //[leftButton sizeToFit];
        
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIView *leftCustomView = [[UIView alloc] initWithFrame: leftButton.frame];
        [leftCustomView addSubview: leftButton];
        UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftCustomView];
        
        viewController.navigationItem.leftBarButtonItem=leftItem;
        [viewController setHidesBottomBarWhenPushed:YES];
 
    }

    [super pushViewController:viewController animated:animated];

    viewController.navigationController.interactivePopGestureRecognizer.enabled = YES;
    viewController.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)back {

    if (self.diffBack)
    {
            NSLog(@"backdelegate");
        self.diffBack();
    }else
    {
       NSLog(@"back");
       [self popViewControllerAnimated:YES];
    }
    
    
    
}


@end
