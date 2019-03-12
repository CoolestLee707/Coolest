//
//  MVPModel.m
//  Coolest
//
//  Created by daoj on 2019/3/11.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "MVPModel.h"

@implementation MVPModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
