//
//  RACView.h
//  Coolest
//
//  Created by daoj on 2019/3/27.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACView : UIView

@property (nonatomic,strong)RACSubject *racSingnal;

//- (void)btnClcik:(UIButton *)btn;

@property (nonatomic,strong)UITextField *textField;

@end

NS_ASSUME_NONNULL_END
