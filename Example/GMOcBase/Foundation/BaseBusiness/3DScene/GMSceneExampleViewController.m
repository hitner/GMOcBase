//
//  GMSceneExampleViewController.m
//  GMOcBase_Example
//
//  Created by liuzhuzhai on 2018/11/21.
//  Copyright © 2018 hitner. All rights reserved.
//

#import "GMSceneExampleViewController.h"
#import "GMFloatableView.h"
#import "GMDebugControlView.h"
#import "GMFaceTrack.h"
#import "GMMacro.h"
#import "UIView+GM.h"
#import "GM2DProcess.h"
#import "GMCalculateLandmark.h"

@import SceneKit;
@import Vision;

@interface GMSceneExampleViewController ()<GMFloatableViewDelegate, GMDebugControlViewDelegate, GMFaceTrackDelegate>
@property(nonatomic, weak) SCNView * theView;
@property(nonatomic, weak) SCNScene * theScene;

@property(nonatomic, weak) GMFloatableView * floatableView;
@property(nonatomic, weak) GMDebugControlView * debugControlView;

@property(nonatomic) GMFaceTrack * faceTrack;
@property(nonatomic) GMCalculateLandmark * calculateLandmark;

@end

@implementation GMSceneExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
    SCNView * scnView = [[SCNView alloc] initWithFrame:[UIScreen mainScreen].bounds options:nil];
    self.theView = scnView;
    SCNScene * one = [self sceneFromAssets];
    //one.rootNode.paused = YES;
    self.theScene = one;
    [scnView setScene:one];
    scnView.debugOptions = SCNDebugOptionShowSkeletons | SCNDebugOptionShowBoundingBoxes |SCNDebugOptionShowConstraints;
    scnView.showsStatistics = YES;
    scnView.allowsCameraControl = YES;
    [self.view addSubview:scnView];
    
    [self removeAnimationForEye];
    
    [self addAssistView];
    [self beginFaceTrack];
    self.calculateLandmark = [[GMCalculateLandmark alloc] init];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.faceTrack stop];
}


- (void)beginFaceTrack {
    self.faceTrack = [[GMFaceTrack alloc] init];
    self.faceTrack.delegate = self;
    UIView * resultView = [[UIView alloc] initWithFrame:CGRectMake(100, 40, 160, 160*heightWidthRadio)];
    [self.faceTrack showPreviewOnView:resultView withFrame:resultView.bounds];
    //[self.faceTrack start];
    [self.view addSubview:resultView];
    [resultView enableFloatable:YES];
}

- (void)addAssistView
{
    GMFloatableView * floatView = [[GMFloatableView alloc] initWithFrame:CGRectMake(0, 0, 350, 150)];
    floatView.delegate = self;
    [self.view addSubview:floatView];
    self.floatableView = floatView;
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 10, 300, 30 )];
    [floatView addSubview:slider];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self addContorlButton];
}

- (void)sliderChanged:(UISlider*)slider {
    
    NSLog(@"slider value:%@", @(slider.value));
    [self updateLeftEyeOpening:slider.value];
    [self updateRightEyeOpening:slider.value];
}

- (void)addContorlButton {
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, 60, 40)];
    [btn setTintColor:[UIColor redColor]];
    [btn setBackgroundColor:[UIColor blueColor] ];
    [btn setTitle:@"START" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.floatableView addSubview:btn];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 60, 40)];
    [btn2 setTintColor:[UIColor redColor]];
    [btn2 setBackgroundColor:[UIColor blueColor] ];
    [btn2 setTitle:@"STOP" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [self.floatableView addSubview:btn2];
    
    btn2 = [[UIButton alloc]initWithFrame:CGRectMake(180, 50, 60, 40)];
    [btn2 setTintColor:[UIColor redColor]];
    [btn2 setBackgroundColor:[UIColor blueColor] ];
    [btn2 setTitle:@"FACE" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(startFace:) forControlEvents:UIControlEventTouchUpInside];
    [self.floatableView addSubview:btn2];
}

- (void)start:(id)sender {
    NSLog(@"start ...");
    [self.theScene setPaused:NO];
}
- (void)stop:(id)sender {
    NSLog(@"stop ...");
    [self.theScene setPaused:YES];
}
- (void)startFace:(id)sender {
    [self.faceTrack start];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (SCNScene *)codeAScene {
    SCNScene * scene = [SCNScene scene];
    
    SCNMaterial * redMaterial = [SCNMaterial material];
    redMaterial.diffuse.contents = [[UIColor redColor] colorWithAlphaComponent:0.5];
    
    SCNMaterial * blueMaterial = [SCNMaterial material];
    blueMaterial.diffuse.contents = [[UIColor blueColor] colorWithAlphaComponent:0.8];
    
    SCNBox * box = [SCNBox boxWithWidth:2 height:2 length:4 chamferRadius:0.1];
    box.materials = @[redMaterial, blueMaterial];
    //[box insertMaterial:redMaterial atIndex:0];
    SCNNode * element = [SCNNode nodeWithGeometry:box];
    [element addChildNode:[self sphereNode]];
    [element addChildNode:[self planeNode]];
    
    [scene.rootNode addChildNode:element];
    //SCNGeometry * geometry = [SCNGeometry ge]
    return scene;
}

- (SCNNode *)sphereNode {
    SCNMaterial * material = [SCNMaterial material];
    material.diffuse.contents = [UIImage imageNamed:@"lizhi"];
    SCNSphere * sphere = [SCNSphere sphereWithRadius:0.1];
    sphere.firstMaterial = material;
    
    SCNNode * node = [SCNNode nodeWithGeometry:sphere];
    node.position = SCNVector3Make(2, 2, 2);
    return node;
}


- (SCNNode *)planeNode {
    SCNMaterial * material = [SCNMaterial material];
    material.diffuse.contents = [UIImage imageNamed:@"Teki"];
    SCNPlane * plane = [SCNPlane planeWithWidth:6 height:6];
    plane.firstMaterial = material;
    
    SCNNode * node = [SCNNode nodeWithGeometry:plane];
    //node.position = SCNVector3Make(3, 4, 5);
    
    SCNMatrix4 mm4 =  node.transform;
    SCNMatrix4 mm5 = SCNMatrix4Rotate(mm4, 360, 1, 1, 1);
    
    CABasicAnimation * animation = [ CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithSCNMatrix4:mm4];
    animation.toValue = [NSValue valueWithSCNMatrix4:mm5];
    animation.duration = 10.0;
    animation.autoreverses = NO;
    animation.repeatCount = 1;
    
    SCNAnimation * scnAnimation = [SCNAnimation animationWithCAAnimation:animation];
    scnAnimation.duration = 10.0;
    
    
    [node addAnimation:scnAnimation forKey:@"plane_animation"];
    //node.eulerAngles = SCNVector3Make(45, 45, 180);
    //SCNMatrix4 mm = node.transform;
    SCNNode * nodeParent = [SCNNode node];
    nodeParent.position = SCNVector3Make(3, 4, 4);
    [nodeParent addChildNode:node];
    return nodeParent;
    
}


- (SCNScene *)sceneFromAssets {
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"dog" withExtension:@"scnassets"];
    NSBundle * sceneBundle = [NSBundle bundleWithURL:url];
    NSURL * file = [sceneBundle URLForResource:@"test02" withExtension:@"dae"];
    SCNSceneSource * sceneSource = [SCNSceneSource sceneSourceWithURL:file options:nil];
    
    NSArray * a = [sceneSource identifiersOfEntriesWithClass:[CAAnimation class]];
    NSArray * b = [sceneSource identifiersOfEntriesWithClass:[SCNSkinner class]];
    
    NSMutableArray * caarray = [[NSMutableArray alloc] init];
    for (NSString * key in a) {
        [caarray addObject:[sceneSource entryWithIdentifier:key withClass:[CAAnimation class]]];
    }
    
    
    for (id ca in caarray) {
        if ([ca isKindOfClass:[CAKeyframeAnimation class]]) {
            CAKeyframeAnimation * cakey = (CAKeyframeAnimation*)ca;
            NSLog(@"<<<<<<< :%@",cakey.keyPath);
            NSArray * cavalues = [cakey values];
            for (NSValue * value in cavalues) {
                SCNMatrix4  m4 = value.SCNMatrix4Value;
                NSLog(@"m4:%@",@(m4.m11));
                //[value getValue:&m4];
                //value ge
            }
        }
    }
    
    NSError * error;
    /*NSURL * targetUrl = [NSURL URLWithString:@"test.dae" relativeToURL:url];
    SCNScene * one = [SCNScene sceneWithURL:targetUrl options:@{} error:&error];
    */
    
    
    return [sceneSource sceneWithOptions:nil error:&error];
}

- (void)removeAnimationForEye {
    SCNNode * leftEye = [self.theScene.rootNode childNodeWithName:@"eyes_l_skins_up" recursively:YES];
    NSArray * keys = [leftEye animationKeys];
    for (NSString *key in keys) {
        SCNAnimationPlayer * animationPlayer = [leftEye animationPlayerForKey:key];
        SCNAnimation * animation = animationPlayer.animation;
        NSLog(@"animation:%@",animation.keyPath);
    }
    [leftEye removeAllAnimations];
    
}

#pragma mark - delegate

- (void)didTouchUpInsideFloatableView:(GMFloatableView *)view {
    NSLog(@"floatable view");
    
    
}

#pragma mark - debug view

- (GMDebugControlView*)debugControlView {
    if (_debugControlView) {
        GMDebugControlView * debugView = [[GMDebugControlView alloc]initWithFrame:self.view.bounds];
        debugView.delegate = self;
        debugView.dataSource = [self debugItems];
        [self.view addSubview:debugView];
        _debugControlView = debugView;
    }
    return _debugControlView;
}

- (NSArray*)debugItems {
    return @[];
    
}

#pragma mark - track result
- (void)faceObservation:(VNFaceObservation *)observation inTrack:(GMFaceTrack *)track {
    CGFloat normalizedHeight = track.videoResolution.height/ track.videoResolution.width;
    CGRect boundingRect = VNImageRectForNormalizedRect(observation.boundingBox, 1, normalizedHeight);
    CGAffineTransform trans2 =  CGAffineTransformMakeTranslation(boundingRect.origin.x, boundingRect.origin.y);
    CGAffineTransform trans = CGAffineTransformScale(trans2, CGRectGetWidth(boundingRect),  CGRectGetHeight(boundingRect));
    
    VNFaceLandmarks2D * mark = observation.landmarks;
    
    
    
    //头以鼻子为中心的旋转角度
    
    CGFloat slope = 0;
    CGFloat constant = 0;
    CGFloat leftRightSlope = [self.calculateLandmark slopeForPoint:mark.medianLine.normalizedPoints
                                    transform:trans
                                        count:mark.medianLine.pointCount
                                        slope:&slope
                                     constant:&constant];
    
    //计算脸部重心和大小
    CGSize faceSize ;
    CGPoint faceWeightPoint;
    [GM2DProcess weightPoint:&faceWeightPoint
                   forPoints:mark.faceContour.normalizedPoints
                   transform:trans
                       count:mark.faceContour.pointCount];
    
    CGAffineTransform transsize = CGAffineTransformRotate(trans, -leftRightSlope); //垂直方向计算脸的大小
    [GM2DProcess size:&faceSize forPoints:mark.faceContour.normalizedPoints transform:transsize count:mark.faceContour.pointCount];
    
    //NSLog(@"weight point(%f,%f), size:%f,%f", faceWeightPoint.x, faceWeightPoint.y, faceSize.width, faceSize.height);
    //依据重心位置求解摆头角度
    CGFloat shouldX = constant;
    if (slope) {
        shouldX = (faceWeightPoint.y - constant)/slope;
    }
    CGFloat yRotate = -2.0*(faceWeightPoint.x - shouldX )/faceSize.width;
    //NSLog(@"y rotation:%f",yRotate);
    [self updateHeadRotation:SCNVector3Make(0, yRotate, leftRightSlope)];
    
    //眼睛参数
    CGFloat leftOpening = [self.calculateLandmark eyeOpeningForPoint:mark.leftEye.normalizedPoints
                                                          transform:trans
                                                              count:mark.leftEye.pointCount];
    CGFloat rightOpening = [self.calculateLandmark eyeOpeningForPoint:mark.rightEye.normalizedPoints
                                                           transform:trans
                                                               count:mark.rightEye.pointCount];
    [self updateLeftEyeOpening:leftOpening];
    [self updateRightEyeOpening:rightOpening];
}

- (void)updateHeadRotation:(SCNVector3) vector3 {
    
    SCNNode * leftEye = [self.theScene.rootNode childNodeWithName:@"head" recursively:YES];
    leftEye.eulerAngles = vector3;
}

- (void)updateLeftEyeOpening:(CGFloat)scale {
    //NSLog(@"left eye scale:%f",scale);
    SCNNode * leftEye = [self.theScene.rootNode childNodeWithName:@"eyes_r_skins_up" recursively:YES];
    [self updateEyeOpening:leftEye scale:scale];
}

- (void)updateRightEyeOpening:(CGFloat)scale {
    SCNNode * rightEye = [self.theScene.rootNode childNodeWithName:@"eyes_l_skins_up" recursively:YES];
    [self updateEyeOpening:rightEye scale:scale];
}

- (void)updateEyeOpening:(SCNNode*)eye scale:(CGFloat)scale {
    eye.eulerAngles = SCNVector3Make(100.0* (1.0-scale)* M_PI / 180, 0, 0);;
}
@end
