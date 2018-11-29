//
//  msgPerson.h
//  Coolest
//
//  Created by daoj on 2018/11/29.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface msgPerson : NSObject

- (void)sendMessageInstance:(NSString *)msg;

+ (void)sendMessageClass:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
