//
//  UIViewController+Monitor.m
//  Coolest
//
//  Created by LiChuanmin on 2020/6/15.
//  Copyright © 2020 CoolestLee707. All rights reserved.
//

#import "UIViewController+Monitor.h"
#import <Aspects/Aspects.h>
#import <objc/runtime.h>


#define X23_UUID [NSUUID new].UUIDString
#define VCTag @"1000"

static char UIViewControllerLoadViewKey;
static char UIViewControllerTag;


@implementation UIViewController (Monitor)

+ (void)load
{
    [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        
        UIViewController* vc=info.instance;
        
        NSString *uuidStr = X23_UUID;
        
        objc_setAssociatedObject(vc, &UIViewControllerLoadViewKey,uuidStr,OBJC_ASSOCIATION_COPY);
        objc_setAssociatedObject(vc, &UIViewControllerTag,@"0",OBJC_ASSOCIATION_COPY);
        
//        ADLog(@"start1 - %@",uuidStr);

    } error:nil];
    
    
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        
        UIViewController* vc=info.instance;

        NSString *x23UUID = objc_getAssociatedObject(vc, &UIViewControllerLoadViewKey);
        NSString *vcTag = objc_getAssociatedObject(vc, &UIViewControllerTag);

        
        if([vcTag isEqualToString:@"0"]){
            
//            ADLog(@"start2 - %@ -- %@",x23UUID,vc.title);
            objc_setAssociatedObject(vc, &UIViewControllerTag,VCTag,OBJC_ASSOCIATION_COPY);

        }
        
    } error:nil];
    
    
}
@end
