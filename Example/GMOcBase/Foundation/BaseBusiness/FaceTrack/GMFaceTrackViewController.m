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


API_AVAILABLE(ios(11.0))
@interface GMFaceTrackViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic, strong) AVCaptureSession * captureSession;
@property(nonatomic, strong) AVCaptureDevice * frontVideoCaptureDevice;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
@property(nonatomic, strong) UIView * rootView;

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
    [self.captureSession startRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.captureSession stopRunning];
    [super viewDidDisappear:animated];
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
                            NSLog(@"track end >>>>>>>>>>");
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
    
    NSLog(@"drop sample Buffer:%@", @(_sampleCount));
    _sampleCount++;
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"capture <<<<<< Buffer:%@", @(_sampleCount));
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
}
@end
