//
//  UIButton+CMButton.h
//  Coolest
//
//  Created by daoj on 2018/12/3.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CMButton)

- (void)addTargetSelected:(void(^)(UIButton *button))block;

@end

NS_ASSUME_NONNULL_END
