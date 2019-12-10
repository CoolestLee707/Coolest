//
//  weakTestView.h
//  Coolest
//
//  Created by daoj on 2019/5/30.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface weakTestView : UIView

@property (nonatomic,copy) void(^touchBlock)(NSString *str);

- (instancetype)initWeakTestView;

@end

NS_ASSUME_NONNULL_END
