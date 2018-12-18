//
//  GMFaceTrack.h
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/18.
//  Copyright © 2018 hitner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GMFaceTrack;
@class VNFaceObservation;
@class AVCaptureVideoPreviewLayer;

@protocol GMFaceTrackDelegate <NSObject>

@optional
- (void)faceObservation:(VNFaceObservation *)observation inTrack:(GMFaceTrack*)track;

@end

@interface GMFaceTrack : NSObject
/*
 * width一般为屏幕宽度， height为屏幕高度（竖屏）,只适应竖屏
 */
@property(nonatomic, readonly) CGSize videoResolution;
@property(nonatomic, readonly) AVCaptureVideoPreviewLayer * previewLayer;
@property(nonatomic, weak)id<GMFaceTrackDelegate> delegate;
/*
 * view 可以为nil，即不展示预览
 */
- (instancetype)init;

/*
 * 必须在start之前调用
 */
- (void)showPreviewOnView:(UIView *) view withFrame:(CGRect)frame ;
- (void)start;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
