//
//  YMSLogHelper.h
//  Pods-YMSLog_Example
//
//  Created by wenxiao su on 2022/10/21.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YMSLogLevel) {
    kYMSLevelAll = 0,
    kYMSLevelVerbose = 0,
    kYMSLevelDebug,// Detailed information on the flow through the system.
    kYMSLevelInfo, // Interesting runtime events (startup/shutdown), should be conservative and keep to a minimum.
    kYMSLevelWarn, // Other runtime situations that are undesirable or unexpected, but not necessarily "wrong".
    kYMSLevelError,// Other runtime errors or unexpected conditions.
    kYMSLevelFatal,// Severe errors that cause premature termination.
    kYMSLevelNone, // Special level used to disable all log messages.
};


NS_ASSUME_NONNULL_BEGIN

@interface YMSLogHelper : NSObject

+ (void)logWithLevel:(YMSLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message;

+ (void)logWithLevel:(YMSLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ...;

+ (BOOL)shouldLog:(YMSLogLevel)level;


@end

#define LogInternal(level, module, file, line, func, prefix, format, ...) \
do { \
    if ([YMSLogHelper shouldLog:level]) { \
        NSString *aMessage = [NSString stringWithFormat:@"%@%@", prefix, [NSString stringWithFormat:format, ##__VA_ARGS__, nil]]; \
        [YMSLogHelper logWithLevel:level moduleName:module fileName:file lineNumber:line funcName:func message:aMessage]; \
    } \
} while(0)

NS_ASSUME_NONNULL_END
