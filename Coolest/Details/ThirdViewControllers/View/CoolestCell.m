//
//  CoolestCell.m
//  Coolest
//
//  Created by daoj on 2018/10/25.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "CoolestCell.h"

@implementation CoolestCell


+ (instancetype)CreateCoolestCell:(UITableView *)tableview
{
//    static NSString *cellId = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        cell.backgroundColor = TabbarColor;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    static NSString *cellID = @"CoolestCellID";
    CoolestCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CoolestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = TabbarColor;
        cell.textLabel.textColor = UIColor.blackColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
