//
//  DrawRectViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/4/25.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "DrawRectViewController.h"
#import "WBLayerView.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

//https://www.jianshu.com/p/9a9e986f9571
@interface DrawRectViewController ()
@property (nonatomic,strong)WBLayerView * layerView;

@end

@implementation DrawRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统绘制-异步绘制";
    
    self.view.backgroundColor = [UIColor blueColor];
    self.layerView = [[WBLayerView alloc]init];
    [self.view addSubview:self.layerView];
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.right.bottom.offset(30);
        make.right.offset(-30);

    }];
    self.layerView.backgroundColor = [UIColor yellowColor];
    
    self.layerView.content = @"这是传入的展示内容";
    [self.layerView setNeedsDisplay];

}

- (void)testViewAndLayerSize {
    UIView *v1 = [[UIView alloc] init];
    CALayer *c1 = [[CALayer alloc] init];
       
    ADLog(@"v1对象实际需要的内存大小: %zd", class_getInstanceSize([v1 class]));
    ADLog(@"v1对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(v1)));
    ADLog(@"c1对象实际需要的内存大小: %zd", class_getInstanceSize([c1 class]));
    ADLog(@"c1对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(c1)));
}

@end
