//
//  CLOrderDictionary.h
//  Coolest
//
//  Created by LiChuanmin on 2022/7/17.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLOrderDictionary : NSObject

- (void)CLSetValue:(id)value forKey:(NSString *)key;
- (id)CLValueForKey:(NSString *)key;

- (void)CLSetValue:(id)value atIndex:(NSUInteger)index;
- (id)CLvalueOfIndex:(NSUInteger)index;

- (NSArray *)CLallKeys;
@end

NS_ASSUME_NONNULL_END
