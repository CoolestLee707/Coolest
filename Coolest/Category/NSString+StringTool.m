//
//  NSString+StringTool.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "NSString+StringTool.h"
#import "NSObject+SwizzledMethod.h"

@implementation NSString (StringTool)

- (NSURL *)url{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
#pragma clang diagnostic pop
}

+ (NSString *)getThisYearString
{
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterMediumStyle];
    [dateformatter setDateFormat:@"yyyy"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateformatter setTimeZone:timeZone];
    NSString *yearStr =  [dateformatter stringFromDate:senddate];
    return yearStr;
}


- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)constrainedToSize
{
    return [self sizeWithFont:font
            constrainedToSize:constrainedToSize
                lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)constrainedToSize
         lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect rect = [self boundingRectWithSize:constrainedToSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

@end
