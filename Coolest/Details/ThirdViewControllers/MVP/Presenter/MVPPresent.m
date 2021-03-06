//
//  MVPPresent.m
//  Coolest
//
//  Created by daoj on 2019/3/11.
//  Copyright © 2019 CoolestLee707. All rights reserved.
//

#import "MVPPresent.h"
#import "MVPService.h"

@interface MVPPresent ()

@property (nonatomic,strong) MVPService *mvpService;
@property (nonatomic,weak) id<MVPProtocol> attachView;


@end

@implementation MVPPresent

- (void)attachView:(id <MVPProtocol>)view
{
    self.attachView = view;
    self.mvpService  = [[MVPService alloc] init];
}

- (void)fetchData {
    [self getUserDatas];
}

- (void)getUserDatas {
    [self.attachView showIndicator];
    [_mvpService getUserInfosSuccess:^(NSDictionary *dic) {
        [self.attachView hideIndicator];
        NSArray *userArr = [dic valueForKey:@"data"];
        
        if ([self processOriginDataToUIFriendlyData:userArr].count == 0) {
            [self.attachView showEmptyView];
        }
        [self.attachView userViewDataSource:[self processOriginDataToUIFriendlyData:userArr]];
    } andFail:^(NSDictionary *dic) {
        
    }];
}

/**
 如果数据比较复杂，或者UI渲染的数据只是其中很少一部分，将原数据处理，输出成UI渲染的数据。（题外话：这里其实还可以使用协议，提供不同的数据格式输出。）
 
 @param originData 原始数据
 @return 将原始数据转换为UI需要数据
 */
- (NSArray<MVPModel *> *)processOriginDataToUIFriendlyData:(NSArray *)originData {
    NSMutableArray<MVPModel *> *friendlyUIData = [NSMutableArray array];
    for (NSDictionary *dic in originData) {
        
        //只处理部分数据
        if ([[dic valueForKey:@"gender"] isEqualToString:@"male"]) {
            MVPModel *model = [MVPModel userWithDict:dic];
            [friendlyUIData addObject:model];
        }
    }
    return friendlyUIData;
}
@end
