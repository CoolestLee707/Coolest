//
//  PersonBlock.m
//  Coolest
//
//  Created by daoj on 2019/4/15.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "PersonBlock.h"

@implementation PersonBlock

-(PersonBlock*)run1
{
    ADLog(@"run1");
    
    return [[PersonBlock alloc] init];

}
-(PersonBlock*)study1
{
    ADLog(@"study1");
    return [[PersonBlock alloc] init];

}

-(PersonBlock* (^)(void))run2
{
    PersonBlock* (^block)(void) = ^{
        ADLog(@"run2");
        return self;
    };
    return block;
}
-(PersonBlock* (^)(void))study2
{
    PersonBlock* (^block)(void) = ^{
        ADLog(@"study2");
        return self;
    };
    return block;
}

-(PersonBlock* (^)(NSString *name))run3
{
    PersonBlock* (^block)(NSString *name) = ^(NSString *name){
        ADLog(@"run3-%@",name);
        return self;
    };
    return block;
}
-(PersonBlock* (^)(NSString *book))study3
{
    PersonBlock* (^block)(NSString *book) = ^(NSString *book){
        ADLog(@"study3-%@",book);
        return self;
    };
    return block;
}
@end
