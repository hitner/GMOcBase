//
//  NSString+GM.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/5.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "NSString+GM.h"
#import "NSData+GM.h"

@implementation NSString (GM)

+ (instancetype)jsonStringFromId:(id)object {
    return [[NSString alloc] initWithData:[NSData jsonStringFromId:object] encoding:NSUTF8StringEncoding];
}

- (id)jsonObject {
    NSError * error ;
    id result = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    NSAssert(error == nil, @"json serial error");
    if (error) {
        return nil;
    }
    else {
        return result;
    }
}

- (NSData*)base64Data {
    return [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSInteger)hexIntegerValue {
    unsigned long long outVal = 0;
    NSScanner* scanner = [NSScanner scannerWithString:self];
    BOOL ret = [scanner scanHexLongLong:&outVal];
    NSAssert(ret, @"integerValueOfHex error");
    return outVal;
}

/* 计算最适合的长度 */
- (CGFloat)fitWidthWithFontSize:(CGFloat)fontSize {
    NSAssert(fontSize > 1.0, @"font size error");
    return [self fitSizeWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                            font:[UIFont systemFontOfSize:fontSize]].width;
}

/* 计算最适合size */
- (CGSize)fitSizeWithSize:(CGSize)size
                     font:(UIFont*)font {
    NSAssert(font, @"font is nil");
    CGRect labelRect = [self boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName :font}
                                          context:nil];
    return labelRect.size;
}

/// 移除头尾空白符（不含换行）
- (NSString*)stringByTrimmingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/// 移除头尾的空白和换行
- (NSString*)stringByTrimmingWhitespaceAndNewline {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
