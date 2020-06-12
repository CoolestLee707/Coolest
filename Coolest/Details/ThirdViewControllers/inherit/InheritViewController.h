//
//  InheritViewController.h
//  Coolest
//
//  Created by LiChuanmin on 2020/6/10.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InheritViewController : BaseViewController

@property(nonatomic,copy)void(^callBack)(NSString *result);

@end

NS_ASSUME_NONNULL_END
