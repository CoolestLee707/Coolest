//
//  objc1.m
//  Coolest
//
//  Created by daoj on 2019/5/9.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "objc1.h"

@implementation objc1
- (void)run
{
    ADLog(@"1run");
}
- (void)run12
{
    ADLog(@"2run");
    [self.ob2 run2];

}
@end
