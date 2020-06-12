//
//  Inherit_Father.m
//  Coolest
//
//  Created by LiChuanmin on 2020/6/10.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "Inherit_Father.h"

@implementation Inherit_Father

- (void)eat
{
    testInheritString = NSStringFromClass([self class]);
    ADLog(@"%@",testInheritString);
}

- (void)log
{
    ADLog(@"%@",testInheritString);
    
    [self run];
}

- (void)run
{
    ADLog(@"run----%@",testInheritString);
}

- (void)delay:(void(^)(NSString *result))complete
{
    dispatch_queue_t queue = dispatch_queue_create("CoolestLee707.Coolest", DISPATCH_QUEUE_CONCURRENT);

       dispatch_async(queue, ^{
           sleep(5);
          if (complete) {
               complete(@"ok");
           }
       });
}
- (void)dealloc {
    ADLog(@"father over");
}
@end
