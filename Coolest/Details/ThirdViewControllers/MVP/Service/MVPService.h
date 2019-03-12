//
//  MVPService.h
//  Coolest
//
//  Created by daoj on 2019/3/12.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

/**
 用来做数据获取工作等，发起网络请求，并且返回数据(字典)给Presenter

 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessHandler)(NSDictionary *dict);
typedef void(^FailHandler)(NSDictionary *dict);

@interface MVPService : NSObject

- (void)getUserInfosSuccess:(SuccessHandler)success andFail:(FailHandler)fail;

@end

NS_ASSUME_NONNULL_END
