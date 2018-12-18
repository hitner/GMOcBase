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

@import SceneKit;

@interface GMSceneExampleViewController ()<GMFloatableViewDelegate, GMDebugControlViewDelegate, GMFaceTrackDelegate>
@property(nonatomic, weak) SCNView * theView;
@property(nonatomic, weak) SCNScene * theScene;

@property(nonatomic, weak) GMFloatableView * floatableView;
@property(nonatomic, weak) GMDebugControlView * debugControlView;

@property(nonatomic) GMFaceTrack * faceTrack;
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
    [self.faceTrack start];
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
    SCNNode * leftEye = [self.theScene.rootNode childNodeWithName:@"eyes_skins_up02" recursively:YES];
    leftEye.eulerAngles = SCNVector3Make(100*slider.value* M_PI / 180, 0, 0);
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
}

- (void)start:(id)sender {
    NSLog(@"start ...");
    SCNNode * skelton = [self.theScene.rootNode childNodeWithName:@"skeleton" recursively:YES];
    NSLog(@"%@",skelton.skinner);
    [self.theScene setPaused:NO];
}
- (void)stop:(id)sender {
    NSLog(@"stop ...");
    [self.theScene setPaused:YES];
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
    NSURL * file = [sceneBundle URLForResource:@"body" withExtension:@"dae"];
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
    SCNNode * leftEye = [self.theScene.rootNode childNodeWithName:@"eyes_skins_up02" recursively:YES];
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
    
    
}
@end
