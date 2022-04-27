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

@property (nonatomic,copy) NSString *nameId;

- (void)addTargetSelected:(void(^)(UIButton *button))block;


// 链式设置属性
- (UIButton *(^)(NSString * normalTitle))normalTitle;
- (UIButton *(^)(NSString * selectedTitle))selectedTitle;
- (UIButton *(^)(UIColor *normalTitleColor))normalTitleColor;
- (UIButton *(^)(UIColor *selectedTitleColor))selectedTitleColor;
- (UIButton *(^)(NSString *normalImageName))normalImageName;
- (UIButton *(^)(NSString *selectedImageName))selectedImageName;
- (UIButton *(^)(CGFloat fontSize))fontSize;

@end

NS_ASSUME_NONNULL_END
