//
//  GMFaceTrack.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/12/18.
//  Copyright © 2018 hitner. All rights reserved.
//
@import AVFoundation;
@import Vision;
#define GMLog NSLog
#import "GMFaceTrack.h"
@interface GMFaceTrack()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic, strong) AVCaptureSession * captureSession;
//@property(nonatomic, strong) AVCaptureDevice * frontVideoCaptureDevice;

@property(nonatomic, weak) UIView * rootView;
@property(nonatomic) CGSize drawSize; //aspect fill 后绘图大小

@property(nonatomic) CALayer * overlayLayer;
@property(nonatomic) CAShapeLayer * faceRectLayer;
@property(nonatomic) CAShapeLayer * landmarkLayer;

@property(nonatomic, strong) VNImageRequestHandler* imageFaceReqHandler;
@property(nonatomic, strong) VNImageRequestHandler * imageEyeReqHandler;//面部细节识别
@property(nonatomic, strong) VNSequenceRequestHandler * seqReqHandler;

@property(nonatomic, strong) VNDetectFaceRectanglesRequest * deteckFaceReq;
//@property(nonatomic, strong) VNDetectFaceLandmarksRequest *
@property(nonatomic, strong) NSArray<VNTrackObjectRequest * >* trackReqArray;//一副图x像里面可能有多个face
@end


@implementation GMFaceTrack


- (instancetype)init {
    self = [super init];
    [self _initVideoCaptureSession];
    [self _initDetectReq];
    return self;
}

- (void)showPreviewOnView:(UIView *) view withFrame:(CGRect)frame {
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    previewLayer.backgroundColor = [UIColor blackColor].CGColor;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    previewLayer.frame = frame;
    [view.layer addSublayer:previewLayer];
    _previewLayer = previewLayer;
    self.rootView = view;
    self.drawSize = frame.size;
    [self configLandmarkLayer];
}

- (void)start {
    [self.captureSession startRunning];
}


- (void)stop {
    [self.captureSession stopRunning];
}

#pragma mark - 内部初始化

- (void)_initVideoCaptureSession {
    self.captureSession = [[AVCaptureSession alloc] init];
    //获取摄像头
    AVCaptureDevice * frontVideoCaptureDevice = nil;
    AVCaptureDeviceDiscoverySession * discoverySession =
    [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                                           mediaType:AVMediaTypeVideo
                                                            position:AVCaptureDevicePositionFront];
    if(discoverySession.devices.count > 0) {
        frontVideoCaptureDevice = discoverySession.devices.firstObject;
    }
    if (!frontVideoCaptureDevice) {
        GMLog(@"error, no front video device");
        return;
    }
    
    //设置DeviceInput
    NSError * error;
    AVCaptureDeviceInput * deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:frontVideoCaptureDevice error:&error];
    if (error) {
        GMLog(@"init device input error:%@",error);
        return;
    }

    if ([self.captureSession canAddInput:deviceInput]) {
        [self.captureSession addInput:deviceInput];
    }
    
    //设置device解析度
    [self configVideoResolution:frontVideoCaptureDevice];
        
    //设置DeviceOutput
    AVCaptureVideoDataOutput * videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoDataOutput.alwaysDiscardsLateVideoFrames = YES;
    dispatch_queue_t queue = dispatch_queue_create("com.lizhi.FaceTrack", DISPATCH_QUEUE_SERIAL);
    [videoDataOutput setSampleBufferDelegate:self queue:queue];
    
    if([self.captureSession canAddOutput:videoDataOutput]) {
        [self.captureSession addOutput:videoDataOutput];
    }
    
    AVCaptureConnection* connection =  [videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    connection.enabled = YES;
    if (@available(iOS 11.0, *)) {
        if (connection.isCameraIntrinsicMatrixDeliverySupported) {
            connection.cameraIntrinsicMatrixDeliveryEnabled = YES;
        }
    }
}


- (void)configVideoResolution:(AVCaptureDevice *)device {
    for(AVCaptureDeviceFormat * format in device.formats) {
        if (CMFormatDescriptionGetMediaSubType(format.formatDescription) == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) {
            CMVideoDimensions dimension = CMVideoFormatDescriptionGetDimensions(format.formatDescription);
            NSLog(@"format dimension:%@,%@",@(dimension.width), @(dimension.height));
        }
    }
    
    AVCaptureDeviceFormat * current_format = device.activeFormat;
    CMVideoDimensions dimension = CMVideoFormatDescriptionGetDimensions(current_format.formatDescription);
    
    _videoResolution = CGSizeMake(dimension.height, dimension.width);
    NSLog(@"current dimension:%@,%@",@(_videoResolution.width), @(_videoResolution.height));
    
}
#pragma mark - 检查与跟踪

- (void)_initDetectReq {
    if (@available(iOS 11.0, *)) {
        self.seqReqHandler = [[VNSequenceRequestHandler alloc] init];
        self.deteckFaceReq = [[VNDetectFaceRectanglesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
            if (error) {
                NSLog(@"face detection error:%@",error);
            }
            NSLog(@"detect face end,result:%@",@(request.results.count));
            if (request.results.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSMutableArray * trackObjectList = [[NSMutableArray alloc] init];
                    for (VNDetectedObjectObservation * observation in request.results) {
                        VNTrackObjectRequest * trackObject = [[VNTrackObjectRequest alloc] initWithDetectedObjectObservation:observation completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
                            //NSLog(@"track end >>>>>>>>>>");
                        }];
                        [trackObjectList addObject:trackObject];
                        NSLog(@"GOOD!,here is:%@",observation);
                    }
                    self.trackReqArray = trackObjectList;
                });
                
            }
            
        }];
    } else {
        // Fallback on earlier versions
    }
    
}

#pragma mark - landmark 显示设置

- (void)configLandmarkLayer {
    CALayer * ca = [[CALayer alloc] init];
    //ca.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.2].CGColor;
    ca.frame = self.previewLayer.frame;
    [self.rootView.layer addSublayer:ca];
    self.overlayLayer = ca;
    
    CAShapeLayer * cb = [[CAShapeLayer alloc] init];
    //cb.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.3].CGColor;
    cb.frame = ca.bounds;
    cb.fillColor = nil;
    cb.strokeColor = [UIColor redColor].CGColor;
    cb.lineWidth = 1;
    [ca addSublayer:cb];
    self.faceRectLayer = cb;
    
    
    CAShapeLayer * cc = [[CAShapeLayer alloc] init];
    cc.frame = ca.bounds;
    cc.fillColor = nil;
    cc.strokeColor = [UIColor yellowColor].CGColor;
    cc.lineWidth = 0.5;
    [ca addSublayer:cc];
    
    //cc.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3].CGColor;
    self.landmarkLayer = cc;
    //[self updateLayerGeometr];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (@available(iOS 11.0, *)) {
        CFTypeRef attachment = CMGetAttachment(sampleBuffer, kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, nil);
        NSObject * attachmentId = (__bridge NSObject*)attachment;
        NSDictionary * optionDict = @{VNImageOptionCameraIntrinsics:attachmentId};
        
        CVImageBufferRef bufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
        if(!bufferRef) {
            return;
        }
        CGImagePropertyOrientation orientation = kCGImagePropertyOrientationLeftMirrored;
        if (self.trackReqArray.count) {
            [self tracking:bufferRef option:optionDict orientation:orientation];
        }
        else {
            //人脸检测
            NSLog(@"start detect face");
            self.imageFaceReqHandler = [[VNImageRequestHandler alloc] initWithCVPixelBuffer:bufferRef
                                                                                orientation:orientation
                                                                                    options:optionDict];
            NSError* error;
            [self.imageFaceReqHandler performRequests:@[self.deteckFaceReq] error:&error];
            if (error) {
                NSLog(@"perform error:%@",error);
            }
        }
    }
}

#pragma mark - tracking detail
- (void)tracking:(CVImageBufferRef)buffer
          option:(NSDictionary*)option
     orientation:(CGImagePropertyOrientation)orientation{
    NSError * error;
    [self.seqReqHandler performRequests:self.trackReqArray onCVPixelBuffer:buffer orientation:orientation error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    //过滤结果
    NSMutableArray * newTrack = [[NSMutableArray alloc] init];
    NSMutableArray * faceRectResult = [[NSMutableArray alloc] init];
    for (VNTrackObjectRequest * trackRequest in self.trackReqArray) {
        if (trackRequest.results.count) {
            VNDetectedObjectObservation * obser = trackRequest.results[0];
            [faceRectResult addObject:obser];
            if (!trackRequest.isLastFrame){
                if(obser.confidence > 0.6) {
                    trackRequest.inputObservation = obser;
                }
                else {
                    trackRequest.lastFrame = YES;
                }
                [newTrack addObject:trackRequest];
            }
        }
    }
    self.trackReqArray = newTrack;
    
    //脸部细节检查
    NSMutableArray * landmarkRequests = [[NSMutableArray alloc ]init];
    for (VNTrackObjectRequest * trackRequest in self.trackReqArray) {
        if (trackRequest.results.count) {
            VNDetectedObjectObservation * obser = trackRequest.results[0];
            
            VNDetectFaceLandmarksRequest * landmarkReq = [[VNDetectFaceLandmarksRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"face land marks error for request:%@",error);
                    return;
                }
                VNDetectFaceLandmarksRequest * landmark = (VNDetectFaceLandmarksRequest*)request;
                if (landmark.results.count) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self trackResult:landmark.results];
                    });
                }
            }];
            VNFaceObservation * faceRect;
            if (@available(iOS 12.0, *)) {
                faceRect = [VNFaceObservation faceObservationWithRequestRevision:0 boundingBox:obser.boundingBox roll:@(0) yaw:@(0)];
            } else {
                // Fallback on earlier versions
                faceRect = (VNFaceObservation*) [VNDetectedObjectObservation observationWithBoundingBox:obser.boundingBox ];
            }
            [landmarkReq setInputFaceObservations:@[faceRect]];
            [landmarkRequests addObject:landmarkReq];
        }
    }
    
    if (landmarkRequests.count) {
        self.imageEyeReqHandler = [[VNImageRequestHandler alloc] initWithCVPixelBuffer:buffer
                                                                           orientation:orientation
                                                                               options:option];
        NSError * error;
        [self.imageEyeReqHandler performRequests:landmarkRequests error:&error];
        if (error) {
            NSLog(@"landmark detect error:%@",error);
        }
    }
    
    
    if (faceRectResult.count) {
        
    }
}

- (void)trackResult:(NSArray<VNFaceObservation*> * )obsers {
    GMLog(@"get the result");
    if ([self.delegate respondsToSelector:@selector(faceObservation:inTrack:)]) {
        [self.delegate faceObservation:obsers.firstObject inTrack:self];
    }
    if (self.rootView) {
        //draw the result
        [CATransaction begin];
        [CATransaction setValue:@(1) forKey:kCATransactionDisableActions];
        CGMutablePathRef rectPath = CGPathCreateMutable();
        CGMutablePathRef landmarkPath = CGPathCreateMutable();
        for (VNFaceObservation* obser in obsers) {
            CGRect  rect = VNImageRectForNormalizedRect(obser.boundingBox,self.drawSize.width,self.drawSize.height);
            CGRect visualRect = CGRectMake(rect.origin.x, self.drawSize.height - CGRectGetMaxY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
            if (@available(iOS 12.0, *)) {
                //NSLog(@"track roll:%@, yaw:%@, rect:%d,%d,%d,%d", obser.roll, obser.yaw, (int)rect.origin.x, (int)rect.origin.y, (int)rect.size.width, (int)rect.size.height);
                
            } else {
                // Fallback on earlier versions
            }
            CGPathAddRect(rectPath, NULL, visualRect);
            
            [self addLandmarkPath:landmarkPath landmark:obser.landmarks inRect:rect];
        }
        self.faceRectLayer.path = rectPath;
        self.landmarkLayer.path = landmarkPath;
        [CATransaction commit];
    }
}



- (void)addLandmarkPath:(CGMutablePathRef)path landmark:(VNFaceLandmarks2D*)mark inRect:(CGRect)rect {
    
    CGAffineTransform trans =  CGAffineTransformMakeTranslation(rect.origin.x, self.drawSize.height - rect.origin.y);
    CGAffineTransform trans2 = CGAffineTransformScale(trans, rect.size.width, - rect.size.height);
    //trans = CGAffineTransformRotate(trans2, M_PI);
    
    NSArray * targetRegions = @[mark.leftEyebrow,
                                mark.rightEyebrow,
                                mark.faceContour,
                                mark.noseCrest,
                                mark.medianLine];
    for (VNFaceLandmarkRegion2D * region in targetRegions) {
        const CGPoint *points = region.normalizedPoints;
        if (region.pointCount) {
            CGPathMoveToPoint(path, &trans2, points->x, points->y);
            CGPathAddLines(path, &trans2, points, region.pointCount);
        }
    }
    
    NSArray * closedRegions = @[mark.leftEye,
                                mark.rightEye,
                                mark.outerLips,
                                mark.innerLips,
                                mark.nose];
    for (VNFaceLandmarkRegion2D * region in closedRegions) {
        const CGPoint *points = region.normalizedPoints;
        if (region.pointCount) {
            CGPathMoveToPoint(path, &trans2, points->x, points->y);
            CGPathAddLines(path, &trans2, points, region.pointCount);
            CGPathAddLineToPoint(path, &trans2, points->x, points->y);
            CGPathCloseSubpath(path);
        }
    }
}

@end
