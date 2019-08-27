//
//  SimpleFactory.m
//  Coolest
//
//  Created by daoj on 2019/8/20.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "SimpleFactory.h"

@implementation SimpleFactory

+ (id<Product>)createProduct:(NSString *)productName{
    
    if ([productName isEqualToString:NSStringFromClass([ProductA class])]) {
        return [[ProductA alloc]init];
    }else if ([productName isEqualToString:NSStringFromClass(ProductB.class)]){
        return [[ProductB alloc]init];
    }else{
        return nil;
    }
}

@end
