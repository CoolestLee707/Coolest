//
//  testModule2.h
//  Coolest
//
//  Created by LiChuanmin on 2022/4/28.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//描述一个类是一个不能被继承的类。testModule2不能被继承
__attribute__((objc_subclassing_restricted))

// 代码混淆
__attribute__((objc_runtime_name("WBXXXX")))

@interface testModule2 : NSObject

@end


//@interface te3 : testModule2
//
//@end

NS_ASSUME_NONNULL_END
