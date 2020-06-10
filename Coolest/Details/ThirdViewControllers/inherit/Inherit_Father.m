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

@end
