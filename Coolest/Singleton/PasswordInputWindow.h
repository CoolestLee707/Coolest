//
//  PasswordInputWindow.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordInputWindow : UIWindow

+ (instancetype)shareInstance;

- (void)show;

//1、通过重写方法，让创建的对象唯一，我们同样也可以通过编译器告诉外面，alloc，new，copy，mutableCopy方法不可以直接调用。否则编译不过。代码如下！
+(instancetype) alloc __attribute__((unavailable("call shareInstance instead")));
+(instancetype) new __attribute__((unavailable("call shareInstance instead")));
-(instancetype) copy __attribute__((unavailable("call shareInstance instead")));
-(instancetype) mutableCopy __attribute__((unavailable("call shareInstance instead")));



- (void)ocFunc __attribute__((deprecated("这个方法将来就要废弃！！！")));
- (void)signalTest __attribute__((objc_requires_super));//一个子类继承父类的方法时，需要调用 super，否则给出编译警告。
// attribute修饰参数1和参数2不为空
- (NSString *)addString1:(NSString *)str1 str2:(NSString *)str2  __attribute__((nonnull (1,2))) __attribute__((warn_unused_result));

@end
