//
//  AppDelegate.m
//  FengHuaKe
//
//  Created by 工博计算机 on 18/3/7.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+EaseMob.h"
#import "EaseUI.h"
#import <IQKeyboardManager.h>
#import "FriendsShowTBVC.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "WXApi.h"

#import <UMCommon/UMCommon.h> // 公共组件是所有友盟产品的基础组件，必选
#import <UMShare/UMShare.h>   // 友盟分享

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

BMKMapManager* _mapManager;
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //[IQKeyboardManager sharedManager].toolbarManageBehaviour =
    
    // UMConfigure 通用设置，请参考SDKs集成做统一初始化。
    [UMConfigure initWithAppkey:@"5c738dcfb465f563c6000820" channel:nil];
    // 以下仅列出U-Share初始化部分
    // U-Share 平台设置
    [self configUSharePlatforms];
    
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    NSString *mapkey = @"awxQ0kPjWsLSZRKNw5OGGVLMhPTOVRWQ";
    
    NSLog(@"%@",[HttpTool isNavX]?@"YES":@"NO");

    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    /**
     *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    BOOL ret = [_mapManager start:mapkey generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //模拟用户类型
    [userDefault setObject:@"M" forKey:@"usertype"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self easemobApplication:application
       didFinishLaunchingWithOptions:launchOptions
                      appkey:EMOAppKEY
                apnsCertName:APNsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxc5ae6deddb9e1f11" appSecret:@"7dfafcc1c296f972a6b599e5fe6f34c3" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106934636"/*设置QQ平台的appID*/  appSecret:@"2gtW0QaHbW9W38n8" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    //[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

- (void)showHint:(NSString *)hint
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


#pragma mark - 支付宝回调

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    NSLog(@" openURL");
    
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"AlipaySDK处理支付结果:result = %@",resultDic);
            }];
        }
    }
    return result || [WXApi handleOpenURL:url delegate:self];
    
    return YES;
}


// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    //    NSLog(@"result:%@",url);
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                
                if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
                    //[SVProgressHUD showSuccessWithStatus:@"已取消"];
                    [self showHint:@"已取消"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@6001];
                }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                    //[SVProgressHUD showErrorWithStatus:@"订单支付失败"];
                    [self showHint:@"订单支付失败"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@4000];
                }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {
                    //[SVProgressHUD showErrorWithStatus:@"网络连接出错"];
                    [self showHint:@"网络连接出错"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@6002];
                }if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                    [self showHint:@"订单支付成功"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@9000];
                    //[SVProgressHUD showSuccessWithStatus:@"订单支付成功"];
                }
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                // 解析 auth code
                NSString *result = resultDic[@"resultStatus"];
                if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]) {
                    //[SVProgressHUD showSuccessWithStatus:@"已取消"];
                    [self showHint:@"已取消"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@6001];
                }else if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                    //[SVProgressHUD showErrorWithStatus:@"订单支付失败"];
                    [self showHint:@"订单支付失败"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@4000];
                }else if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {
                    //[SVProgressHUD showErrorWithStatus:@"网络连接出错"];
                    [self showHint:@"网络连接出错"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@6002];
                }if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                    [self showHint:@"订单支付成功"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_ALIPAY object:@9000];
                    //[SVProgressHUD showSuccessWithStatus:@"订单支付成功"];
                }
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
        }
    }
    return result;
    
    return YES;
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   //iOS6及以下系统，收到通知
     [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
}

// 通知的点击事件
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
//
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
     [[EMClient sharedClient] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}




@end
