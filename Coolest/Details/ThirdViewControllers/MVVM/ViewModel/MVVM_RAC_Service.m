//
//  MVVM_RAC_Service.m
//  Coolest
//
//  Created by daoj on 2019/3/14.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "MVVM_RAC_Service.h"
#import "MVVM_RAC_Cell.h"
#import "MVVM_RAC_Model.h"

@implementation MVVM_RAC_Service

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    MVVM_RAC_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[MVVM_RAC_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    kWeakSelf(weakSelf);
    [self.viewModel configCell:cell CellIndexPath:indexPath];
    cell.tapBlock = ^(NSString * _Nonnull tapString) {
        ADLog(@"tapString - - %@",tapString);
        
        MVVM_RAC_Model *model = weakSelf.viewModel.dataArray[indexPath.row];
        weakSelf.viewModel.contentKey = model.name;
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MVVM_RAC_Model *model = self.viewModel.dataArray[indexPath.row];
    self.viewModel.contentKey = model.name;
}
@end
