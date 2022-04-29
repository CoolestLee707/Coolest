//
//  MVVM_RAC_ViewModel.m
//  Coolest
//
//  Created by daoj on 2019/3/13.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "MVVM_RAC_ViewModel.h"
#import "MVVM_RAC_Model.h"

@implementation MVVM_RAC_ViewModel

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (instancetype)initWithSuccess:(successBlock)successBlock Faile:(faileBlock)faileBlock
{
    if (self = [super init]) {
        _success = successBlock;
        _faile = faileBlock;
    }
    
    [RACObserve(self, contentKey) subscribeNext:^(id  _Nullable x) {
       
        ADLog(@"改变 - %@",x);
        [self.dataArray removeAllObjects];
        if (x) {
            NSArray *arr = @[@"11111",@"22222",@"33333",@"44444",@"55555",@"66666",@"77777",@"88888",@"99999",@"00000",@"-----"];
            for (int i=0; i<arr.count; i++) {
                
                if (![arr[i] isEqualToString:x]) {
                    
                    MVVM_RAC_Model *model = [[MVVM_RAC_Model alloc]init];
                    model.name = arr[i];
                    [self.dataArray addObject:model];
                }
            }
            !self.success?:self.success();
        }
       
    }];
    
    return self;
}
- (void)getData
{    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self.dataArray removeAllObjects];
        
        [NSThread sleepForTimeInterval:2];

        NSArray *arr = @[@"-11111",@"-22222",@"-33333",@"-44444",@"-55555",@"-66666",@"-77777",@"-88888",@"-99999",@"-00000",@"-----"];
        
        for (int i=0; i<arr.count; i++) {
            MVVM_RAC_Model *model = [[MVVM_RAC_Model alloc]init];
            model.name = arr[i];
            [self.dataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (self.dataArray.count) {
                if (self.success) {
                    self.success();
                }
            }else {
                if (self.faile) {
                    self.faile();
                }
            }
        });
        
    });
}

- (void)configCell:(MVVM_RAC_Cell *)cell CellIndexPath:(NSIndexPath *)indexPath
{
    MVVM_RAC_Model *model = self.dataArray[indexPath.row];
    cell.nameLabel.text = model.name;
}
@end
