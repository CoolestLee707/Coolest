//
//  MVPProtocol.h
//  Coolest
//
//  Created by daoj on 2019/3/12.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MVPProtocol <NSObject>

- (void)userViewDataSource:(NSArray<MVPModel *> *)data;

- (void)showIndicator;

- (void)hideIndicator;

- (void)showEmptyView;

@end

NS_ASSUME_NONNULL_END
