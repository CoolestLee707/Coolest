//
//  CameraViewController.h
//  Coolest
//
//  Created by daoj on 2018/11/23.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraViewController : UIViewController

@property(nonatomic,copy)void(^takeComplete)(UIImage *);

@end

NS_ASSUME_NONNULL_END
