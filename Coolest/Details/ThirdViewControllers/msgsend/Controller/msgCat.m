//
//  msgCat.m
//  
//
//  Created by LiChuanmin on 2022/4/16.
//

#import "msgCat.h"

@implementation msgCat

@synthesize name = _name;
- (void)setName:(NSString *)name {
    _name = name;
}

- (NSString *)name {
    return _name;
}
// Instance
- (void)sendMessageInstance:(NSString *)msg{
    ADLog(@"--- sendMessageInstance %@ = %@",[self class],msg);
}

+ (void)sendMessageInstance:(NSString *)msg{
    ADLog(@"+++ sendMessageInstance %@ = %@",[self class],msg);
}

// Class
- (void)sendMessageClass:(NSString *)msg{
    ADLog(@"--- sendMessageClass %@ = %@",[self class],msg);
}

+ (void)sendMessageClass:(NSString *)msg{
    ADLog(@"+++ sendMessageClass %@ = %@",[self class],msg);
}

@end
