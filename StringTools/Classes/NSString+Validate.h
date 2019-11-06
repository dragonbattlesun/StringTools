//
//  NSString+Validate.h
//  Pods
//
//  Created by sunxuzhu on 2019/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Validate)

/// 判断字符串是否为空 或者 null
/// @param text NSString
+ (BOOL)stringIsNull:(NSString *)text;

/// 删除字符串首尾的空格
/// @param string NSString
+ (NSString *)trimWithString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
