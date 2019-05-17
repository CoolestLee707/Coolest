//
//  MVVM_RAC_Cell.h
//  Coolest
//
//  Created by daoj on 2019/3/14.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVVM_RAC_Cell : UITableViewCell

@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic,copy) void (^tapBlock)(NSString *tapString);

@end

NS_ASSUME_NONNULL_END
