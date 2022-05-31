//
//  CMPerson.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/14.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "CMPerson.h"

@implementation CMPerson

- (void)eat {
    ADLog(@"CMPerson-----eat");
}

- (void)dealloc {
    ADLog(@"%s",__func__);
}
@end
