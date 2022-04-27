//
//  WBServiceProtocol.h
//  WBCube
//
//  Created by 金修博 on 2018/6/18.
//  Copyright © 2018年 金修博. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WBServiceProtocol <NSObject>
@optional
+ (BOOL)singleton;      //是否使用单例模式
+ (id)sharedInstance;    //单例对象
@end
