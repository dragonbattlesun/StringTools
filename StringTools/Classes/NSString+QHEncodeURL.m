//
//  NSString+QHEncodeURL.m
//  encodeURL
//
//  Created by sunxuzhu on 2019/11/5.
//  Copyright © 2019 sunxuzhu. All rights reserved.
//

#import "NSString+QHEncodeURL.h"
#import "NSString+Validate.h"
@implementation NSString (QHEncodeURL)

/// URL 编码
- (NSString *)encodeURLString{
    NSString *escapeCharasterString = @"!*'();:@+$,&=/?%#[]";
    NSCharacterSet *allowedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:escapeCharasterString] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters: allowedCharacterSet];
}

/// URL 解码
- (NSString *)decodeURLString{
    NSString *result = [self stringByRemovingPercentEncoding];
    return result;
}

- (NSString *)urlStringWithParameter:(NSDictionary *)params{
    NSMutableString *urlString = [NSMutableString stringWithString:self];
    BOOL hasQuestionFlag = NO; //是否存在?
    NSRange range = [self rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        hasQuestionFlag = YES;
    }
    for (NSString *key in [params allKeys]) {
        if (hasQuestionFlag) {
            [urlString appendFormat:@"&%@=%@",key,params[key]];
        }else{
            [urlString appendFormat:@"?%@=%@",key,params[key]];
            hasQuestionFlag = YES;
        }
    }
    return urlString;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters{
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return params;
    }
    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents) {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSRange valueRange = [keyValuePair rangeOfString:[NSString stringWithFormat:@"%@=",key]];
            NSString *value = [keyValuePair substringWithRange:NSMakeRange(NSMaxRange(valueRange), keyValuePair.length - NSMaxRange(valueRange))];
            if (![NSString stringIsNull:value]) {
                value = [value stringByRemovingPercentEncoding];
            }
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if (existValue != nil) {
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    [params setValue:items forKey:key];
                } else {
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}


/*
 url parameter value to All encode
 example http://wwww.baidu.com?title=测试&#*哈哈
 encodeString result http://wwww.baidu.com?title=%e6%b5%8b%e8%af%95%26%23*%e5%93%88%e5%93%88
 */
- (NSString *)encodedString{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CFStringRef encodeParaCf = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
    #pragma clang diagnostic pop
}

@end
