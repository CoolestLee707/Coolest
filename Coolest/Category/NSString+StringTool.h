//
//  NSString+StringTool.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringTool)

- (NSURL *)url;

+ (NSString *)getThisYearString;

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)constrainedToSize;
@end
