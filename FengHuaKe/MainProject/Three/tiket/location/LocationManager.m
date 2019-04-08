//
//  LocationManager.m
//  ZHONGHUILAOWU
//
//  Created by 秦根 on 2018/4/17.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationManager()<CLLocationManagerDelegate>
@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *currentProvince;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度
@property(nonatomic,copy) LocationBlock  locationBlock;
@property(nonatomic,copy)La_Lo_nameBlock  la_Lo_nameBlock ;
@end
@implementation LocationManager
+(instancetype)shareInstabce
{
    static dispatch_once_t onceToken;
    static LocationManager *location=nil;
    dispatch_once(&onceToken, ^{
        location=[[LocationManager alloc]init];
    });
    return location;
    
}
-(void)startLocation:(LocationBlock)locationBlock
{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
        self.locationBlock = locationBlock;
    }
    
  
}
//获取详细地址 经纬度
-(void)startLocationLa_Lo_name:(La_Lo_nameBlock)la_Lo_nameBlock{
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
        self.la_Lo_nameBlock= la_Lo_nameBlock;
    }
    
}
#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];

    UIViewController *vc=[self topViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];

    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
  
    if (_currentCity.length> 0){//如果调用已经一次，不再执行
//          NSLog(@"_currentCity:%@",_currentCity);
        return;
    }
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            _currentCity = placeMark.locality;
            _currentProvince=placeMark.administrativeArea;
            if (!_currentCity) {
                _currentCity = @"";
            }
            if (!_currentProvince) {
                _currentProvince=@"";
            }
         

            if (self.locationBlock) {
                self.locationBlock(_currentProvince,_currentCity);
            }
            
            if (self.la_Lo_nameBlock) {
                self.la_Lo_nameBlock(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, placeMark.name);
            }
        }else if (error == nil && placemarks.count){
         
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
}

#pragma mark private
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
