//
//  MVPPresent.h
//  Coolest
//
//  Created by daoj on 2019/3/11.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPProtocol.h"
#import "MVPModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVPPresent : NSObject

/**
 将一个实现了 MVPProtocol 协议的对象绑定到 presenter上来
 
 @param view 实现了UserViewProtocol的对象，一般来说，应该就是控制器，在MVP中，V 和 VC 共同组成UI 层
 */
- (void)attachView:(id <MVPProtocol>)view;

/**
 这个是对外的入口，通过这个入口，实现多个对内部的操作，外部只要调用这个接口就可以了
 */
- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
