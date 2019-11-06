//
//  NSString+Validate.m
//  Pods
//
//  Created by sunxuzhu on 2019/11/6.
//

#import "NSString+Validate.h"
@implementation NSString (Validate)

/// 判断字符串是否为空 或者 null
/// @param text NSString
+ (BOOL)stringIsNull:(NSString *)text {
    if ((NSNull *)text == [NSNull null]){
        return YES;
    }
    if (text == nil || [text length] == 0){
        return YES;
    }
    return NO;
}

/// 删除字符串首尾的空格
/// @param string NSString
+ (NSString *)trimWithString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
