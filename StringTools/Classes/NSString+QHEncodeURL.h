//
//  NSString+QHEncodeURL.h
//  encodeURL
//
//  Created by sunxuzhu on 2019/11/5.
//  Copyright © 2019 sunxuzhu. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QHEncodeURL)

/// URL 编码
- (NSString *)encodeURLString;

/// URL 解码
- (NSString *)decodeURLString;


/// URL 参数拼接
/// @param params NSDictionary
- (NSString *)urlStringWithParameter:(NSDictionary *)params;

/**
 *  将URL中的参数以 NSDictionary 返回
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters;

/*
url parameter value to All encode
example http://wwww.baidu.com?title=测试&#*哈哈
encodeString result http://wwww.baidu.com?title=%e6%b5%8b%e8%af%95%26%23*%e5%93%88%e5%93%88
*/
- (NSString *)encodedString;
@end

NS_ASSUME_NONNULL_END
