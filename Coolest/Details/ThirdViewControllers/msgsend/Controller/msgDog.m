//
//  msgDog.m
//  Coolest
//
//  Created by daoj on 2018/11/29.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "msgDog.h"

@implementation msgDog

- (void)sendMessageInstance:(NSString *)msg{
    NSLog(@"--- %@ = %@",[self class],msg);
}

+ (void)sendMessageClass:(NSString *)msg{
    NSLog(@"+++ %@ = %@",[self class],msg);
}

- (void)sendMessageClass:(NSString *)msg{
    NSLog(@"--- %@ = %@",[self class],msg);
}
@end
