//
//  testModule3.h
//  Coolest
//
//  Created by LiChuanmin on 2022/5/1.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "testModule3Protocol.h"

@RouterProtocolService(testModule3Protocol,Service_testModule3)

//Coolest:Target
@RouterSwiftProtocolService(Coolest,SwiftProtocol,Swift_demo)

NS_ASSUME_NONNULL_BEGIN

@interface Service_testModule3 : NSObject <testModule3Protocol>

@end

NS_ASSUME_NONNULL_END
