//
//  crash_report.c
//  GMOcBase
//
//  Created by liu zhuzhai on 2020/3/12.
//

#include "crash_report.h"

#include <signal.h>
#include <stdio.h>


void common_crash_handler(int sig) {
    printf("crash for signal %d", sig);
}

void initSignalHandler() {
    printf("now init signal handler");
    struct sigaction act;
    act.__sigaction_u = (union __sigaction_u)common_crash_handler;
    
    //sigaction(SIGTRAP, &act, NULL);
    sigaction(SIGABRT, &act, NULL);
    //sigaction(SIGILL, &act, NULL);
    //sigaction(SIGINT, &act, NULL);
    //sigaction(SIGKILL, &act, NULL);
}

