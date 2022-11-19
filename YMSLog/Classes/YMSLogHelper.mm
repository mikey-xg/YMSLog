//
//  YMSLogHelper.m
//  Pods-YMSLog_Example
//
//  Created by wenxiao su on 2022/10/21.
//

#import "YMSLogHelper.h"
#import <mars/xlog/xloggerbase.h>
#import <mars/xlog/xlogger.h>
#import <mars/xlog/appender.h>
#import <sys/xattr.h>

static NSUInteger g_processID = 0;

@implementation YMSLogHelper

+ (void)logWithLevel:(YMSLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message {
    
    XLoggerInfo info;
    info.level = [self logLevelFromTALTLogLevel:logLevel];
    info.tag = moduleName;
    info.filename = fileName;
    info.func_name = funcName;
    info.line = lineNumber;
    gettimeofday(&info.timeval, NULL);
    info.tid = (uintptr_t)[NSThread currentThread];
    info.maintid = (uintptr_t)[NSThread mainThread];
    info.pid = g_processID;
    xlogger_Write(&info, message.UTF8String);
}

+ (void)logWithLevel:(YMSLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ... {
    
    if ([self shouldLog:logLevel]) {
        va_list argList;
        va_start(argList, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
        [self logWithLevel:logLevel moduleName:moduleName fileName:fileName lineNumber:lineNumber funcName:funcName message:message];
        va_end(argList);
    }
    
}

+ (BOOL)shouldLog:(YMSLogLevel)level {
    if ([self logLevelFromTALTLogLevel:level] >= xlogger_Level()) {
        return YES;
    }
    return NO;
}


+ (TLogLevel)logLevelFromTALTLogLevel:(YMSLogLevel)lev {
    switch (lev) {
        case kYMSLevelVerbose:
            return kLevelVerbose;
            break;
        
        case kYMSLevelDebug:
            return kLevelDebug;
            break;
            
        case kYMSLevelInfo:
            return kLevelInfo;
            break;
        
        case kYMSLevelWarn:
            return kLevelWarn;
            break;
        
        case kYMSLevelError:
            return kLevelError;
            break;
        
        case kYMSLevelFatal:
            return kLevelFatal;
            break;
        
        case kYMSLevelNone:
            return kLevelNone;
            break;
            
        default:
            return kLevelAll;
            break;
    }
}

@end
