//
//  PersonBlock.h
//  Coolest
//
//  Created by daoj on 2019/4/15.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//
//函数式编程
//链式编程
//函数式编程总结
//
//如果想再去调用别的方法，那么就需要返回一个对象；
//如果想用()去执行，那么需要返回一个block；
//如果想让返回的block再调用对象的方法，那么这个block就需要返回一个对象（即返回值为一个对象的block）。

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonBlock : NSObject

@property (nonatomic,copy) NSString * (^chooseBlock)(NSInteger number);

//返回自己实例对象
-(PersonBlock*)run1;
-(PersonBlock*)study1;

//返回block,()调用返回实例对象
-(PersonBlock* (^)(void))run2;
-(PersonBlock* (^)(void))study2;

-(PersonBlock* (^)(NSString *name))run3;
-(PersonBlock* (^)(NSString *book))study3;

@end

NS_ASSUME_NONNULL_END
