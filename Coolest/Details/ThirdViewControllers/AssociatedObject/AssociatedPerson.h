//
//  AssociatedPerson.h
//  Coolest
//
//  Created by LiChuanmin on 2022/5/16.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssociatedPerson : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) UIViewController *vc;

- (void)setAss:(UIViewController *)vc;
- (void)removeAss:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
