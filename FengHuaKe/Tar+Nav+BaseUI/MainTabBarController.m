//
//  MainTabBarController.m
//  Restaurant
//
//  Created by 张帆 on 16/8/15.
//  Copyright © 2016年 工博计算机. All rights reserved.
//

#import "MainTabBarController.h"
#import "ChatDemoHelper.h"
#import "ApplyViewController.h"
#import "ZWHSystemHomeViewController.h"
#import "GBNavigationController.h"
#import "ZWHBaseNavigationViewController.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";
@interface MainTabBarController ()<CLLocationManagerDelegate>
{
    UIBarButtonItem *_addFriendItem;
    EMConnectionState _connectionState;
}
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@property (nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation MainTabBarController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        [self setEdgesForExtendedLayout: UIRectEdgeNone];
//    }
    
    
    [self configLocationManager];
    self.title=@"聊天";
    //获取未读消息数，此时并没有把self注册为SDK的delegate，读取出的未读数是上次退出程序时的
    //    [self didUnreadMessagesCountChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
    
    [self setupSubviews];
    self.selectedIndex = 0;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,17,17)];
    backButton.accessibilityIdentifier = @"ddFriends";
    [backButton setImage:[UIImage imageNamed:@"addFriends"]  forState:UIControlStateNormal];
    //[backButton addTarget:_contactsVC action:@selector(addFriends) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftCustomView = [[UIView alloc] initWithFrame: backButton.frame];
    [leftCustomView addSubview: backButton];
    _addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:leftCustomView];
//    self.navigationItem.rightBarButtonItem=_addFriendItem;
  
    [self setupUnreadMessageCount];
    [self setupUntreatedApplyCount];
    
    [ChatDemoHelper shareHelper].contactViewVC = _contactsVC;
    [ChatDemoHelper shareHelper].conversationListVC = _chatListVC;
   
}


#pragma mark - 判断定位
-(void)getOpLocation{
    UIAlertController *switchAlertController = [UIAlertController alertControllerWithTitle:@"打开[定位服务]来允许寻工宝确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *sureAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //跳转到定位权限页面
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [switchAlertController addAction:sureAction];
    [switchAlertController addAction:cancelAction];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window.rootViewController presentViewController:switchAlertController animated:YES completion:nil];
}

-(void)configLocationManager{
    
    //第一步 判断设备是否支持定位
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        [self getOpLocation];
        return;
    }
    
    // 1.创建定位管理者
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    self.locationManager = locationManager;
    // 2.想用户请求授权(iOS8之后方法)   必须要配置info.plist文件
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 以下方法选择其中一个
        // 请求始终授权   无论app在前台或者后台都会定位
        //  [locationManager requestAlwaysAuthorization];
        // 当app使用期间授权    只有app在前台时候才可以授权
        [locationManager requestWhenInUseAuthorization];
    }
    // 距离筛选器   单位:米   100米:用户移动了100米后会调用对应的代理方法didUpdateLocations
    // kCLDistanceFilterNone  使用这个值得话只要用户位置改动就会调用定位
    locationManager.distanceFilter = 100.0;
    // 期望精度  单位:米   100米:表示将100米范围内看做一个位置 导航使用kCLLocationAccuracyBestForNavigation
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // 3.设置代理
    locationManager.delegate = self;
    
    // 4.开始定位 (更新位置)
    [locationManager startUpdatingLocation];
    
    // 5.临时开启后台定位  iOS9新增方法  必须要配置info.plist文件 不然直接崩溃
    //locationManager.allowsBackgroundLocationUpdates = YES;
}

// 当定位到用户位置时调用
// 调用非常频繁(耗电)
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    // 一个CLLocation对象代表一个位置
    //NSLog(@"%@",locations);
    //MJWeakSelf
    if ([locations lastObject] != nil) {
        // 停止定位
        [manager stopUpdatingLocation];
        CLLocation *clo = [locations lastObject];
        
        
        //将获得的定位信息转换为对应地址
        if (self.geocoder.isGeocoding) {
            return;
        }
        //反编码
        
        [self.geocoder reverseGeocodeLocation:clo completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获得最新的地标
            CLPlacemark *mark = [placemarks lastObject];
            NSLog(@"%@------%@------%@",mark.administrativeArea,mark.locality,mark.subLocality);
            [userDefault setObject:mark.locality forKey:@"usercity"];
            [userDefault synchronize];
        }];
    }
    
    
}

-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

#pragma mark - private

- (void)setupSubviews
{
    self.tabBar.accessibilityIdentifier = @"tabbar";
    
    

    [[UITabBar appearance] setTranslucent:NO];
    _chatListVC = [[ConversationListController alloc] init];
    [_chatListVC networkChanged:_connectionState];
    _chatListVC.title=@"聊天";
    UIImage  *chatImage=[UIImage imageNamed:@"tabar_1_select"];
    chatImage=[chatImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _chatListVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"聊天"
                                                           image:[UIImage imageNamed:@"tabar_1"]
                                                   selectedImage:chatImage];
    _chatListVC.tabBarItem.tag = 0;
    _chatListVC.tabBarItem.accessibilityIdentifier = @"conversation";
    [self unSelectedTapTabBarItems:_chatListVC.tabBarItem];
    [self selectedTapTabBarItems:_chatListVC.tabBarItem];
    
    _contactsVC = [[ContactListViewController alloc] init];
    _contactsVC.title=@"通讯录";
    _contactsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录"
                                                           image:[UIImage imageNamed:@"tabar_2"]
                                                   selectedImage:[UIImage imageNamed:@"tabar_2_select"]];
    _contactsVC.tabBarItem.tag = 1;
    _contactsVC.tabBarItem.accessibilityIdentifier = @"contact";
    [self unSelectedTapTabBarItems:_contactsVC.tabBarItem];
    [self selectedTapTabBarItems:_contactsVC.tabBarItem];
    
    _catageManagerVC = [[CatageManagerVC alloc] init];
    _catageManagerVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"大系统"
                                                           image:[UIImage imageNamed:@"tabar_3"]
                                                   selectedImage:[UIImage imageNamed:@"tabar_3_select"]];
    /*_catageManagerVC.tabBarItem.tag = 2;
    _catageManagerVC.tabBarItem.accessibilityIdentifier = @"setting";
//    _catageManagerVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self unSelectedTapTabBarItems:_catageManagerVC.tabBarItem];
    [self selectedTapTabBarItems:_catageManagerVC.tabBarItem];*/
    
    _mineViewController = [[MineViewController alloc] init];
    UIImage  *mineImage=[UIImage imageNamed:@"tabar_4_select"];
    mineImage=[mineImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _mineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                                image:[UIImage imageNamed:@"tabar_4"]
                                                        selectedImage:mineImage];
    _mineViewController.tabBarItem.tag = 3;
    _mineViewController.tabBarItem.accessibilityIdentifier = @"setting";
//    _mineViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self unSelectedTapTabBarItems:_mineViewController.tabBarItem];
    [self selectedTapTabBarItems:_mineViewController.tabBarItem];
    
    //张卫煌添加
    _systemHome = [[ZWHSystemHomeViewController alloc] init];
    _systemHome.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"大系统"
                                                                image:[UIImage imageNamed:@"tabar_3"]
                                                        selectedImage:[UIImage imageNamed:@"tabar_3_select"]];
    _systemHome.tabBarItem.tag = 2;
    _systemHome.tabBarItem.accessibilityIdentifier = @"setting";
    //    _catageManagerVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self unSelectedTapTabBarItems:_systemHome.tabBarItem];
    [self selectedTapTabBarItems:_systemHome.tabBarItem];
    
    
    //self.viewControllers = @[_chatListVC, _contactsVC, _catageManagerVC,_mineViewController,_systemHome];
    
    self.viewControllers = @[[[GBNavigationController alloc]initWithRootViewController:_chatListVC],
                             [[GBNavigationController alloc]initWithRootViewController:_contactsVC],[[GBNavigationController alloc]initWithRootViewController:_systemHome],[[GBNavigationController alloc]initWithRootViewController:_mineViewController]];
    // 统一调整横屏模式下 UITabBarItem 的红点和未读数偏移位置（具体值视业务设计不同而不同）
    _mineViewController.tabBarItem.qmui_updatesIndicatorColor = [UIColor redColor];
    _mineViewController.tabBarItem.qmui_badgeBackgroundColor = [UIColor redColor];
    _mineViewController.tabBarItem.qmui_shouldShowUpdatesIndicator = YES;
    _mineViewController.tabBarItem.qmui_badgeInteger = 0;
    //_mineViewController.tabBarItem.qmui_badgeString = @"1";
   
}
-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], NSFontAttributeName,
                                        [UIColor darkGrayColor],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],NSFontAttributeName,
                                       UIColorFromRGB(0x4BA4FF),NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    if (item.tag == 0) {
        self.title = @"聊天";
        self.navigationItem.rightBarButtonItem = nil;
        
     
    }else if (item.tag == 1){
        self.title = @"通讯录";
        self.navigationItem.rightBarButtonItem = _addFriendItem;;

    }else if (item.tag == 2){
        self.title = @"大系统";
        self.navigationItem.rightBarButtonItem = nil;
        
//        [_settingsVC refreshConfig];
    }else if(item.tag == 3)
    {
        self.title = @"我的";
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        self.title = @"new";
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mrak public
//跳转到回话列表
- (void)jumpToChatList
{
   if(_chatListVC)
    {
        [self.navigationController popToViewController:self animated:NO];
        [self setSelectedViewController:_chatListVC];
    }
}
//设置未处理的好友申请
- (void)setupUntreatedApplyCount
{
    NSLog(@"设置未处理的好友申请");
    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
    if (_contactsVC) {
        if (unreadCount > 0) {
            _contactsVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
        }else{
            _contactsVC.tabBarItem.badgeValue = nil;
        }
    }

    [self.contactsVC reloadApplyView];
}
//设置未处理的消息
- (void)setupUnreadMessageCount
{
    NSLog(@"设置未处理的消息");
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (_chatListVC) {
        if (unreadCount > 0) {
            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
        }else{
            _chatListVC.tabBarItem.badgeValue = nil;
        }
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}
//网络发生变化
- (void)networkChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    [_chatListVC networkChanged:connectionState];
}
//收到本地通知
- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}
//收到通知
- (void)didReceiveUserNotification:(UNNotification *)notification
{
    
}
//播放声音
- (void)playSoundAndVibration
{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}
//展示消息通知
- (void)showNotificationWithMessage:(EMMessage *)message
{
    
}

@end
