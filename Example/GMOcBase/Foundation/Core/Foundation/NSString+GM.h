//
//  NSString+GM.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/5.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GM)
/// 把NSArray/NSDictionary 转为NSString
+ (instancetype)jsonStringFromId:(id)object;

/// 将json字符串转化为NSDictionary或NSArray
- (id)jsonObject;

/// 16进制字符串转整数
- (NSInteger)hexIntegerValue;

/// 计算最适合的长度
- (CGFloat)fitWidthWithFontSize:(CGFloat)fontSize;

/// 计算最适合size
- (CGSize)fitSizeWithSize:(CGSize)size
                      font:(UIFont*)font;

/// 移除头尾空白符（不含换行）
- (NSString*)stringByTrimmingWhitespace;

/// 移除头尾的空白和换行
- (NSString*)stringByTrimmingWhitespaceAndNewline;
@end

NS_ASSUME_NONNULL_END
