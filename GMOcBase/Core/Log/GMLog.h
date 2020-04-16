//
//  GMLog.h
//  GMOcBase
//
//  Created by liu zhuzhai on 2020/3/31.
//

#ifndef GMLog_h
#define GMLog_h

#import "GMLogEngine.h"



#define GMLogCommon(level, t, fmt, ...) [[GMLogEngine sharedObject] logWithLevel:level tags:t format:fmt, ##__VA_ARGS__];

#define GMLogWithNSLog(level,tags, fmt,...) NSLog(fmt, ##__VA_ARGS__); \
    GMLogCommon(level,tags,fmt,##__VA_ARGS__)


#ifdef DEBUG
#define GMLogDebug(fmt, ...) GMLogWithNSLog(GMLogLevelDebug,nil,fmt,##__VA_ARGS__)
#define GMLogTagD(TAG,fmt,...) GMLogWithNSLog(GMLogLevelDebug,TAG,fmt,##__VA_ARGS__)
#else
#define GMLogDebug(fmt, ...)
#define GMLogTagD(TAG,fmt,...)
#endif

#ifdef APPSTORE
    


#else
#define GMLogInfo(fmt, ...)GMLogWithNSLog(GMLogLevelInfo,nil,fmt,##__VA_ARGS__)
#define GMLogWarn(fmt, ...) GMLogWithNSLog(GMLogLevelWarn,nil,fmt,##__VA_ARGS__)
#define GMLogError(fmt, ...) GMLogWithNSLog(GMLogLevelError,nil,fmt,##__VA_ARGS__)

#define GMLogTagI(TAG,fmt, ...)GMLogWithNSLog(GMLogLevelInfo,TAG,fmt,##__VA_ARGS__)
#define GMLogTagW(TAG,fmt, ...) GMLogWithNSLog(GMLogLevelWarn,TAG,fmt,##__VA_ARGS__)
#define GMLogTagE(TAG,fmt, ...) GMLogWithNSLog(GMLogLevelError,TAG,fmt,##__VA_ARGS__)

#endif







#endif /* GMLog_h */
