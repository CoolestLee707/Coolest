//
//  MVVM_RAC_Service.h
//  Coolest
//
//  Created by daoj on 2019/3/14.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MVVM_RAC_ViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVM_RAC_Service : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MVVM_RAC_ViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
