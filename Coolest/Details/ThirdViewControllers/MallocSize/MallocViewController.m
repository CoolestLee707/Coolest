//
//  MallocViewController.m
//  Coolest
//
//  Created by LiChuanmin on 2022/6/29.
//  Copyright © 2022 CoolestLee707. All rights reserved.
//

#import "MallocViewController.h"
#import "MallocPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
@interface MallocViewController ()

@end

@implementation MallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"内存大小";
    
    NSMutableArray *arr1 = [NSMutableArray array];
//    40,48, 0x6000008701e0--0x7ff7b8e5d9a8
    ADLog(@"arr1对象实际需要的内存大小: %zd", class_getInstanceSize([arr1 class]));
    ADLog(@"arr1对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(arr1)));
    ADLog(@"%@--%p--%p",arr1,arr1,&arr1);
    
    MallocPerson *p1 = [MallocPerson new];
    MallocPerson *p2 = [MallocPerson new];
    MallocPerson *p3 = [MallocPerson new];
    MallocPerson *p4 = [MallocPerson new];
    MallocPerson *p5 = [MallocPerson new];
    MallocPerson *p6 = [MallocPerson new];
    MallocPerson *p7 = [MallocPerson new];

//    24,32,<MallocPerson: 0x600001883360>--0x600001883360--0x7ff7bd4ad990
    ADLog(@"p1对象实际需要的内存大小: %zd", class_getInstanceSize([p1 class]));
    ADLog(@"p1对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(p1)));
    ADLog(@"%@--%p--%p",p1,p1,&p1);

    [arr1 addObject:p1];
    [arr1 addObject:p2];
    [arr1 addObject:p3];
    [arr1 addObject:p4];
    [arr1 addObject:p5];
    [arr1 addObject:p6];
    [arr1 addObject:p7];

/*    40,48
 (  "<MallocPerson: 0x600001883360>",
     "<MallocPerson: 0x600001881440>",
     "<MallocPerson: 0x600001882d40>",
     "<MallocPerson: 0x600001882a40>",
     "<MallocPerson: 0x600001882a80>",
     "<MallocPerson: 0x600001883180>",
     "<MallocPerson: 0x600001882140>"
 )
 --0x6000008701e0--0x7ff7b8e5d9a8

*/
    ADLog(@"arr1对象实际需要的内存大小: %zd", class_getInstanceSize([arr1 class]));
    ADLog(@"arr1对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(arr1)));
    ADLog(@"%@--%p--%p",arr1,arr1,&arr1);

    
    NSArray *arr2 = [arr1 mutableCopy];

    /*    40,48
     (  "<MallocPerson: 0x600001883360>",
         "<MallocPerson: 0x600001881440>",
         "<MallocPerson: 0x600001882d40>",
         "<MallocPerson: 0x600001882a40>",
         "<MallocPerson: 0x600001882a80>",
         "<MallocPerson: 0x600001883180>",
         "<MallocPerson: 0x600001882140>"
     )
     --0x6000008683c0--0x7ff7b8e5d968
    */
    ADLog(@"arr2对象实际需要的内存大小: %zd", class_getInstanceSize([arr2 class]));
    ADLog(@"arr2对象实际分配的内存大小: %zd", malloc_size((__bridge const void *)(arr2)));
    ADLog(@"%@--%p--%p",arr2,arr2,&arr2);

}



@end
