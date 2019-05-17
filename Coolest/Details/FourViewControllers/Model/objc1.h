//
//  objc1.h
//  Coolest
//
//  Created by daoj on 2019/5/9.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "objc2.h"

NS_ASSUME_NONNULL_BEGIN

@interface objc1 : NSObject
@property (nonatomic,strong) objc2 *ob2;

- (void)run;

- (void)run12;

@end

NS_ASSUME_NONNULL_END
