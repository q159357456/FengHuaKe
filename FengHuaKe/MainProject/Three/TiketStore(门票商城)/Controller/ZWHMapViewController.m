//
//  ZWHMapViewController.m
//  FengHuaKe
//
//  Created by Syrena on 2018/8/22.
//  Copyright © 2018年 gongbo. All rights reserved.
//

#import "ZWHMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@interface ZWHMapViewController ()<BMKMapViewDelegate>

@property(nonatomic,strong)BMKMapView *mapView;

@end

@implementation ZWHMapViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    self.view = _mapView;
    _mapView.zoomLevel = 20;
    
    
    NSString *oreillyAddress = _model.proname;
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = firstPlacemark.location.coordinate.latitude;
            coor.longitude = firstPlacemark.location.coordinate.longitude;
            annotation.coordinate = coor;
            [self.mapView addAnnotation:annotation];
            [self.mapView setCenterCoordinate:coor animated:YES];
            _mapView.gesturesEnabled = NO;
        }
        else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    
    
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    BMKAnnotationView *pStarView = [[BMKAnnotationView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *pImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [pStarView addSubview:pImage];
    [pImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMG,_model.url]]];
    pImage.layer.cornerRadius = 15;
    pImage.layer.masksToBounds = YES;
    pStarView.backgroundColor = [UIColor clearColor];
    return pStarView;
}


@end
