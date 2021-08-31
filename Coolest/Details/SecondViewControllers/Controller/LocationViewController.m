//
//  LocationViewController.m
//  Coolest
//
//  Created by chuanmin li on 2021/8/25.
//  Copyright © 2021 CoolestLee707. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationViewController ()<CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;//定位服务管理类
    CLGeocoder * _geocoder;//初始化地理编码器
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"定位信息获取";
    
    [self initializeLocationService];
}

- (void)initializeLocationService {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    //[_locationManager requestAlwaysAuthorization];//iOS8必须，这两行必须有一行执行，否则无法获取位置信息，和定位
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 开始定位
    [_locationManager startUpdatingLocation];//开始定位之后会不断的执行代理方法更新位置会比较费电所以建议获取完位置即时关闭更新位置服务
    //初始化地理编码器
    _geocoder = [[CLGeocoder alloc] init];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    ADLog(@"%lu",(unsigned long)locations.count);
    CLLocation * location = locations.lastObject;
//    // 纬度
//    CLLocationDegrees latitude = location.coordinate.latitude;
//    // 经度
//    CLLocationDegrees longitude = location.coordinate.longitude;
    ADLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f", location.coordinate.longitude, location.coordinate.latitude,location.altitude,location.course,location.speed);
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            ADLog(@"%@",placemark.name);
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            // 位置名
            ADLog(@"name,%@",placemark.name);
//    　　街道
            ADLog(@"thoroughfare,%@",placemark.thoroughfare);
//    　　 子街道
            ADLog(@"subThoroughfare,%@",placemark.subThoroughfare);
//    　　 市
            ADLog(@"locality,%@",placemark.locality);
//    　　 区
            ADLog(@"subLocality,%@",placemark.subLocality);
//    　　 国家
            ADLog(@"country,%@",placemark.country);
        }else if (error == nil && [placemarks count] == 0) {
            ADLog(@"No results were returned.");
        } else if (error != nil){
            ADLog(@"An error occurred = %@", error);
        }
    }];
//    [manager stopUpdatingLocation];不用的时候关闭更新位置服务
}

@end
