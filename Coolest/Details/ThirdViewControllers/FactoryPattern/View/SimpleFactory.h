//
//  SimpleFactory.h
//  Coolest
//
//  Created by daoj on 2019/8/20.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductA.h"
#import "ProductB.h"
#import "SimpleProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimpleFactory : NSObject

+(id<Product>)createProduct:(NSString *)productName;

@end

NS_ASSUME_NONNULL_END
