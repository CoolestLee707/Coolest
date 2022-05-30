//
//  AspectsViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2020/8/16.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "AspectsViewController.h"
#import "Aspects.h"

@interface AspectsViewController ()

@property(nonatomic,copy)NSString *name;

@end

@implementation AspectsViewController

/*
UIViewController 只alloc而没用到的时候，UIViewController 的view还没有加载。因为：当alloc并init一个Controller时这个Controller还没有创建view，Controller的view是使用lazy init方式创建，就是说你调用的view属性的getter方法:[self view]。在getter方法里会判断view是否创建，如果没有创建那么会调用loadview来创建view，loadview完成后会继续调用viewdidload。

init里不要出现创建view的代码，也不要调用self.view，在init里应该只有相关数据的初始化，而且这些数据都是比较关键的数据。

在init方法里面，设置背景颜色，会生效吗 会生效
*/

+ (void)load {
    [[self class] aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo){
        ADLog(@"-----aspect_hookSelector");
        [aspectInfo.originalInvocation invoke];
        
    } error:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = UIColor.redColor;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    ADLog(@"-----viewWillAppear");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Aspects";
    [NSURL initialize];

    self.name = @"cool";
//    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
  
  
    
}

- (void)dealloc {
    
    ADLog(@"-- %@",self.name);
}
@end
