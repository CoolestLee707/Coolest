//
//  BlockTestObject.m
//  Coolest
//
//  Created by LiChuanmin on 2022/5/11.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "BlockTestObject.h"

typedef void(^saveBlock)(void);

@interface BlockTestObject ()
@property (nonatomic, copy) saveBlock saveblock;
@end

@implementation BlockTestObject

- (void)testMethod:(void(^)(void))block {
    ADLog(@"%s",__func__);
    block();
}

- (void)testMethodSave:(void(^)(void))block {

    self.saveblock = block;
    self.saveblock();
    
}
- (void)dealloc {
    ADLog(@"%s",__func__);
}
@end
