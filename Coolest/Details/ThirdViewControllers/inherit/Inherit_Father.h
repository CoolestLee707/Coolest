//
//  Inherit_Father.h
//  Coolest
//
//  Created by LiChuanmin on 2020/6/10.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Inherit_Father : NSObject
{
    @protected
    NSString *testInheritString;
}

- (void)eat;

- (void)log;

@end

NS_ASSUME_NONNULL_END
