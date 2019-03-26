//
//  MVVM_RAC_ViewModel.h
//  Coolest
//
//  Created by daoj on 2019/3/13.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVM_RAC_Cell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^successBlock)(void);
typedef void(^faileBlock)(void);

@class MVVM_RAC_ViewController;

@interface MVVM_RAC_ViewModel : NSObject

@property (nonatomic,copy)NSString *contentKey;

@property (nonatomic,copy)successBlock success;
@property (nonatomic,copy)faileBlock faile;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,weak)MVVM_RAC_ViewController *vc;

- (instancetype)initWithSuccess:(successBlock)successBlock Faile:(faileBlock)faileBlock;

- (void)getData;

- (void)configCell:(MVVM_RAC_Cell *)cell CellIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
