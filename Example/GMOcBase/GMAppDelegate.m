//
//  GMAppDelegate.m
//  GMOcBase
//
//  Created by hitner on 10/16/2018.
//  Copyright (c) 2018 hitner. All rights reserved.
//

#import "GMAppDelegate.h"

//App
#import "GMApperance.h"

#import "GMNavigationViewController.h"

#include <execinfo.h>
#include <mach/exc.h>
#include <mach/thread_act.h>
#include <pthread.h>


void exceptionHandler(NSException *exception) {
    NSArray * stackSymbols = exception.callStackSymbols;
    for (NSString * one in stackSymbols) {
        NSLog(@"%@",one);
    }
}

void cpp_exception_handler() {
    
}


void ignore_signal_handler() {
    NSLog(@" ignoarl signal handler");
    
    NSSetUncaughtExceptionHandler(exceptionHandler);
    
    
    struct sigaction act;
    act.__sigaction_u = (union __sigaction_u)SIG_DFL;
    
    sigaction(SIGTRAP, &act, NULL);
    sigaction(SIGABRT, &act, NULL);
    sigaction(SIGSEGV, &act, NULL);
    //sigaction(SIGINT, &act, NULL);
    //cannot 
}

void common_crash_handler(int sig,siginfo_t* signalInfo, void* userContext) {
    //thread_suspend(0);
    ignore_signal_handler();
    NSLog(@"crash for signal %d", sig);
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    NSLog(@"has frames:%@",@(frames));
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i < frames; ++i) {
        NSLog(@"%s\n", strs[i]);
    }
    free(strs);
}

const int kExceptionSignals[] = {
   // Core-generating signals.
  SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGQUIT, SIGSEGV, SIGSYS, SIGTRAP, SIGEMT,
  SIGXCPU, SIGXFSZ,
  // Non-core-generating but terminating signals.
  SIGALRM, SIGHUP, SIGINT, SIGPIPE, SIGPROF, SIGTERM, SIGUSR1, SIGUSR2,
  SIGVTALRM, SIGXCPU, SIGXFSZ, SIGIO,
};
const int kNumHandledSignals =
sizeof(kExceptionSignals) / sizeof(kExceptionSignals[0]);

void initSignalHandler() {
    NSLog(@"now init signal handler");
    
    NSSetUncaughtExceptionHandler(exceptionHandler);
    //std::set_terminate(cpp_exception_handler);
    static stack_t sigstk;
    if ((sigstk.ss_sp = malloc(SIGSTKSZ*10)) == NULL) {
        perror("malloc fail");
    }
    sigstk.ss_size = SIGSTKSZ*10;
    sigstk.ss_flags = 0;
    if (sigaltstack(&sigstk,0) < 0)
        perror("sigaltstack");
    
    
    for (int i = 0; i < kNumHandledSignals; ++i) {
      struct sigaction sa;
      memset(&sa, 0, sizeof(sa));
      sigemptyset(&sa.sa_mask);
      sigaddset(&sa.sa_mask, kExceptionSignals[i]);
      sa.sa_sigaction = common_crash_handler;
      sa.sa_flags = SA_SIGINFO;

      if (sigaction(kExceptionSignals[i], &sa, 0) == -1) {
        return ;
      }
    }
    /*
    struct sigaction act;
    memset(&act, 0, sizeof(act));
    act.__sigaction_u = (union __sigaction_u)common_crash_handler;
    act.sa_flags = SA_ONSTACK |SA_SIGINFO |SA_64REGSET;
    sigemptyset(&act.sa_mask);
    
    
    sigaction(SIGTRAP, &act, NULL);
    sigaction(SIGABRT, &act, NULL);
    sigaction(SIGSEGV, &act, NULL);
    sigaction(SIGBUS, &act, NULL);
     */
}


@implementation GMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    initSignalHandler();
    // Override point for customization after application launch.
    [[GMCore sharedObject] initLogger];
    [[GMAppProfile sharedObject] logInfo];
    [[GMApperance sharedObject] initNavigationBarApperance];
    
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController: [GMNavigationViewController sharedObject]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
