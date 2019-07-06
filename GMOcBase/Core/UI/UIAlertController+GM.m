//
//  UIAlertController+GM.m
//  CocoaLumberjack
//
//  Created by liuzhuzhai on 2019/7/6.
//

#import "UIAlertController+GM.h"

@implementation UIAlertController (GM)
/// 好的
+(instancetype)alertControllerWithContent:(NSString*)content {
    return [self alertControllerWithTitle:nil content:content cancelText:@"好的" cancelAction:nil confirmText:nil confirmAction:nil];
}


/// 取消 确定
+(instancetype)alertControllerWithContent:(NSString*)content
                            confirmAction:(GMBlockVoid)confirmBlock {
    return [self alertControllerWithTitle:nil content:content cancelText:@"取消" cancelAction:nil confirmText:@"确定" confirmAction:confirmBlock];
}


/// 全部自定义
+(instancetype)alertControllerWithTitle:(nullable NSString*)title
                                content:(nullable NSString*)content
                             cancelText:(nullable NSString*)cancelText
                           cancelAction:(nullable GMBlockVoid)cancelBlock
                            confirmText:(nullable NSString*)confirmText
                          confirmAction:(nullable GMBlockVoid)confirmBlock {
    if (!cancelText) {
        cancelText = @"取消";
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:content
                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    [alert addAction:defaultAction];
    if (confirmText.length > 0) {
        UIAlertAction * otherAction = [UIAlertAction actionWithTitle:confirmText
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (confirmBlock) {
                                                                 confirmBlock();
                                                                 }
                                                             }];
        [alert addAction:otherAction];
    }
    return alert;
}

+(instancetype)actionSheetControllerWithTitle:(nullable NSString*)title
                                      content:(nullable NSString*)content
                                   cancelText:(nullable NSString*)cancelText
                                 cancelAction:(nullable GMBlockVoid)cancelBlock
                              destructiveText:(nullable NSString*)changeText
                            destructiveAction:(nullable GMBlockVoid)changeBlock; {
    if (!cancelText) {
        cancelText = @"取消";
    }
    
    if (!changeText) {
        changeText = @"确定";
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:content
                                                             preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    [alert addAction:defaultAction];
    
    UIAlertAction * otherAction = [UIAlertAction actionWithTitle:changeText
                                                           style:UIAlertActionStyleDestructive
                                   
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (changeBlock) {
                                                                     changeBlock();
                                                                 }
                                                             }];
    [alert addAction:otherAction];
    return alert;
}
@end
