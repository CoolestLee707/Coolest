//
//  MVPModel.h
//  Coolest
//
//  Created by daoj on 2019/3/11.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVPModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, strong) NSString *addr;

@property (nonatomic, strong) NSString *gender;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
