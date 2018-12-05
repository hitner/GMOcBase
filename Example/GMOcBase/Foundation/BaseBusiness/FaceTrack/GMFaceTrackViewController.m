//
//  GMFaceTrackViewController.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/13.
//  Copyright © 2018 hitner. All rights reserved.
//
@import AVFoundation;
@import Vision;
@import CoreMedia;
#import "GMFaceTrackViewController.h"
#import "UIColor+GM.h"

API_AVAILABLE(ios(11.0))
@interface GMFaceTrackViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic, strong) AVCaptureSession * captureSession;
@property(nonatomic, strong) AVCaptureDevice * frontVideoCaptureDevice;
@property(nonatomic) CGSize videoResolution;//视频宽度

@property(nonatomic, strong) UIView * rootView;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
@property(nonatomic) CALayer * overlayLayer;
@property(nonatomic) CAShapeLayer * faceRectLayer;
@property(nonatomic) CAShapeLayer * landmarkLayer;

@property(nonatomic, strong) VNImageRequestHandler* imageFaceReqHandler;
@property(nonatomic, strong) VNImageRequestHandler * imageEyeReqHandler;//面部细节识别
@property(nonatomic, strong) VNSequenceRequestHandler * seqReqHandler;

@property(nonatomic, strong) VNDetectFaceRectanglesRequest * deteckFaceReq;
//@property(nonatomic, strong) VNDetectFaceLandmarksRequest *
@property(nonatomic, strong) NSArray<VNTrackObjectRequest * >* trackReqArray;//一副图x像里面可能有多个face
@property(nonatomic) NSInteger sampleCount;
@end

@implementation GMFaceTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sampleCount = 0;
    self.captureSession = [[AVCaptureSession alloc] init];
    //AVCaptureDevice * videoCaptureDevice = [AVCaptureDevice def]
    UIView * rootView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.rootView = rootView;
    rootView.layer.masksToBounds = YES;
    [self.view addSubview:rootView];
    
    
    
    [self configVideoCaptureSession];
    [self configPreviewLayer];
    [self configDetectAndTrack];
    
    [self configResultLayer];
    [self.captureSession startRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.captureSession stopRunning];
    [super viewDidDisappear:animated];
}

- (CGPoint)displayCenter {
    return CGPointMake(CGRectGetMidX(self.rootView.bounds) , CGRectGetMidY(self.rootView.bounds));
}

- (AVCaptureDevice*)frontVideoCaptureDevice {
    if (!_frontVideoCaptureDevice) {
        AVCaptureDeviceDiscoverySession * discoverySession =
            [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                                                                                    mediaType:AVMediaTypeVideo
                                                                                                                    position:AVCaptureDevicePositionFront];
        if(discoverySession.devices.count > 0) {
            _frontVideoCaptureDevice = discoverySession.devices.firstObject;
        }
    }
    return _frontVideoCaptureDevice;
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
    NSLog(@"current dimension:%@,%@",@(dimension.width), @(dimension.height));
    self.videoResolution = CGSizeMake(dimension.width, dimension.height);
    
}

- (void)configVideoCaptureSession {
    AVCaptureDevice * device = self.frontVideoCaptureDevice;
    if (!device) {
        
    }
    if (!device) {
        return;
    }
    NSError * error;
    AVCaptureDeviceInput * deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!error) {
        if ([self.captureSession canAddInput:deviceInput]) {
            [self.captureSession addInput:deviceInput];
        }
        [self configVideoResolution:device];
        
        
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
}

- (void)configPreviewLayer {
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    self.previewLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.rootView.layer.bounds;
    [self.rootView.layer addSublayer:self.previewLayer];
}


- (void)configResultLayer {
    CGRect bound = CGRectMake(0, 0,self.videoResolution.height, self.videoResolution.width);
    CGPoint videoCenter = CGPointMake(CGRectGetMidX(bound), CGRectGetMidY(bound));
    CGPoint centerPoint = CGPointMake(0.5, 0.5);
    
    CALayer * ca = [[CALayer alloc] init];
    ca.anchorPoint = centerPoint;
    ca.bounds =  bound;
    ca.position = [self displayCenter];

    ca.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.2].CGColor;

    
    self.overlayLayer = ca;
    [self.rootView.layer addSublayer:ca];
    
    
    CAShapeLayer * cb = [[CAShapeLayer alloc] init];
    cb.bounds = bound;
    cb.anchorPoint = centerPoint;
    cb.position = videoCenter;
    cb.fillColor = nil;
    cb.strokeColor = [UIColor redColor].CGColor;
    cb.lineWidth = 5;
    [ca addSublayer:cb];
    self.faceRectLayer = cb;
    
    
    CAShapeLayer * cc = [[CAShapeLayer alloc] init];
    cc.bounds = bound;
    cc.anchorPoint = centerPoint;
    cc.position = videoCenter;
    cc.fillColor = nil;
    cc.strokeColor = [UIColor blackColor].CGColor;
    cc.lineWidth = 2.0;
    [ca addSublayer:cc];
    
    cc.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3].CGColor;
    self.landmarkLayer = cc;
    [self updateLayerGeometr];
}


- (void)updateLayerGeometr {
    [CATransaction setValue:@(1) forKey:kCATransactionDisableActions];
    
    CGRect videoPreviewRect = self.rootView.bounds;//[self.previewLayer metadataOutputRectOfInterestForRect:CGRectMake(0, 0, 1, 1)];
    //CGFloat rotation = 0;
    CGFloat scaleX = videoPreviewRect.size.width / self.videoResolution.height;
    CGFloat scaleY = videoPreviewRect.size.height / self.videoResolution.width;
    
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(0);
    CGAffineTransform transform2 = CGAffineTransformScale(transform, scaleX, scaleY);
    [self.overlayLayer setAffineTransform:transform2];
    self.overlayLayer.position = [self displayCenter];
}

- (void)drawObservation:(NSArray*)obsers {
    [CATransaction begin];
    [CATransaction setValue:@(1) forKey:kCATransactionDisableActions];
    CGMutablePathRef rectPath = CGPathCreateMutable();
    CGMutablePathRef landmarkPath = CGPathCreateMutable();
    for (VNFaceObservation* obser in obsers) {
        CGRect  rect = VNImageRectForNormalizedRect(obser.boundingBox,self.videoResolution.height,self.videoResolution.width);
        CGRect visualRect = CGRectMake(rect.origin.x, self.videoResolution.width - CGRectGetMaxY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
        if (@available(iOS 12.0, *)) {
            NSLog(@"track roll:%@, yaw:%@, rect:%d,%d,%d,%d", obser.roll, obser.yaw, (int)rect.origin.x, (int)rect.origin.y, (int)rect.size.width, (int)rect.size.height);
            
        } else {
            // Fallback on earlier versions
        }
        CGPathAddRect(rectPath, NULL, visualRect);
        
        [self addLandmarkPath:landmarkPath landmark:obser.landmarks inRect:rect];
    }
    self.faceRectLayer.path = rectPath;
    self.landmarkLayer.path = landmarkPath;
    [self updateLayerGeometr];
    [CATransaction commit];
}

         
- (void)addLandmarkPath:(CGMutablePathRef)path landmark:(VNFaceLandmarks2D*)mark inRect:(CGRect)rect {
    
    CGAffineTransform trans =  CGAffineTransformMakeTranslation(rect.origin.x, self.videoResolution.width - rect.origin.y);
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
         
         
- (void)configDetectAndTrack {
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
#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    //NSLog(@"drop sample Buffer:%@", @(_sampleCount));
    _sampleCount++;
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    //NSLog(@"capture <<<<<< Buffer:%@, videoOrientation:%@", @(_sampleCount),@(connection.videoOrientation));
    _sampleCount++;
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
                        [self drawObservation:landmark.results];
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
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            [self drawObservation:faceRectResult];
//        });
    }
    
}


#pragma mark - draw result
- (void)drawResult {
//    NSMutableArray * result = [[NSMutableArray alloc] init];
//    for (VNTrackObjectRequest * trackRequest in self.trackReqArray) {
//        [result addObjectsFromArray:trackRequest.results];
//    }
}
@end
