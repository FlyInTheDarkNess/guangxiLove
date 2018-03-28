//
//  NSStri.m
//  ZHSQ
//
//  Created by 赵中良 on 15/6/4.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "NSString+SringNull.h"

@implementation NSString (SringNull)

-(BOOL) isEmpty{
    if([self isKindOfClass:[NSNull class]]){
        return NO;
    }
    if (self == nil) {
        return NO;
    }
    if ([self isEqualToString:@"<null>"]||[self isEqualToString:@"(null)"]) {
        return NO;
    }
    NSString *text = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([text length] == 0) {
        return NO;
    }
    return YES;
}

@end
