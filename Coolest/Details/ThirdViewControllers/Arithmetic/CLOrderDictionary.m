//
//  CLOrderDictionary.m
//  Coolest
//
//  Created by LiChuanmin on 2022/7/17.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "CLOrderDictionary.h"

@interface CLOrderDictionary ()

@property (nonatomic,strong) NSMutableDictionary *dic;
@property (nonatomic,strong) NSMutableOrderedSet *orderSet;

@end

@implementation CLOrderDictionary

//lazy load
- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    return _dic;
}

- (NSMutableOrderedSet *)orderSet {
    if (!_orderSet) {
        _orderSet = [[NSMutableOrderedSet alloc]init];
    }
    return _orderSet;
}

- (void)CLSetValue:(id)value forKey:(NSString *)key {
    [self.orderSet addObject:key];
    [self.dic setValue:value forKey:key];
}

- (id)CLValueForKey:(NSString *)key {
    if (![self.orderSet containsObject:key]) {
        return nil;
    }
    return [self.dic objectForKey:key];
}

- (void)CLSetValue:(id)value atIndex:(NSUInteger)index {
    NSString *key = [self.orderSet objectAtIndex:index];
    [self.dic setValue:value forKey:key];
}

- (id)CLvalueOfIndex:(NSUInteger)index {
    NSString *key = [self.orderSet objectAtIndex:index];
    return [self.dic objectForKey:key];
}

- (NSArray *)CLallKeys {
    
    NSMutableArray *arr = [NSMutableArray array];
    [self.orderSet enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [self.dic objectForKey:obj];
        [arr addObject:str];
       }];

    return arr.copy;
}

@end
