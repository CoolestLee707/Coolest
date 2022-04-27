//
//  msgDog.m
//  Coolest
//
//  Created by daoj on 2018/11/29.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import "msgDog.h"

@implementation msgDog

// Instance
//- (void)sendMessageInstance:(NSString *)msg{
//    ADLog(@"--- sendMessageInstance %@ = %@",[self class],msg);
//}

//+ (void)sendMessageInstance:(NSString *)msg{
//    ADLog(@"+++ sendMessageInstance %@ = %@",[self class],msg);
//}

// Class
- (void)sendMessageClass:(NSString *)msg{
    ADLog(@"--- sendMessageClass %@ = %@",[self class],msg);
}

+ (void)sendMessageClass:(NSString *)msg{
    ADLog(@"+++ sendMessageClass %@ = %@",[self class],msg);
}

- (void)eat {
    ADLog(@"%s",__func__);
}
@end
