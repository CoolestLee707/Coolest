//
//  UIAlertView+Block.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)

typedef void(^CompleteBlock) (NSInteger ButtonIndex);

- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end
