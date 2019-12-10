//
//  WeakManager.h
//  Coolest
//
//  Created by daoj on 2019/5/30.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakManager : NSObject

@property (nonatomic,strong)UIViewController *testVc;


+ (WeakManager *)shareInstance;

- (void)openH5URLWithViewController:(UIViewController *)controller withURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
