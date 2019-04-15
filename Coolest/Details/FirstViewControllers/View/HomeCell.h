//
//  HomeCell.h
//  Coolest
//
//  Created by daoj on 2019/4/12.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (nonatomic,copy)void(^clickBlock)(NSString *selectCity);

@end

NS_ASSUME_NONNULL_END
