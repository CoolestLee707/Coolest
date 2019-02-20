//
//  AsyncDisplayModel.h
//  Coolest
//
//  Created by daoj on 2019/2/19.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsyncDisplayModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *descContent;
@property (nonatomic, copy) NSString *detailContent;

@end

NS_ASSUME_NONNULL_END
