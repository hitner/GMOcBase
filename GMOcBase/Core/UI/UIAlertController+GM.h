//
//  UIAlertController+GM.h
//  CocoaLumberjack
//
//  Created by liuzhuzhai on 2019/7/6.
//

#import <UIKit/UIKit.h>

#import "GMMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (GM)


/// 好的
+(instancetype)alertControllerWithContent:(nonnull NSString*)content;


/// 取消 确定
+(instancetype)alertControllerWithContent:(nonnull NSString*)content
                            confirmAction:(nonnull GMBlockVoid)confirmBlock;


/// 全部自定义
+(instancetype)alertControllerWithTitle:(nullable NSString*)title
                                content:(nullable NSString*)content
                             cancelText:(nullable NSString*)cancelText
                           cancelAction:(nullable GMBlockVoid)cancelBlock
                            confirmText:(nullable NSString*)confirmText
                          confirmAction:(nullable GMBlockVoid)confirmBlock;


/// action sheet 样式的删除提醒
+(instancetype)actionSheetControllerWithTitle:(nullable NSString*)title
                              destructiveText:(nullable NSString*)changeText
                            destructiveAction:(nullable GMBlockVoid)changeBlock;

+(instancetype)actionSheetControllerWithTitle:(nullable NSString*)title
                                 alertActions:(NSArray<UIAlertAction*>*)actions;


+(instancetype)actionSheetControllerWithTitle:(nullable NSString*)title
                                      content:(nullable NSString*)content
                                   cancelText:(nullable NSString*)cancelText
                                 cancelAction:(nullable GMBlockVoid)cancelBlock
                              destructiveText:(nullable NSString*)changeText
                            destructiveAction:(nullable GMBlockVoid)changeBlock;
@end

NS_ASSUME_NONNULL_END
