//
//  YMSLogUtil.m
//  Pods-YMSLog_Example
//
//  Created by wenxiao su on 2022/10/21.
//

#import "YMSLogUtil.h"
#import <mars/xlog/xloggerbase.h>
#import <mars/xlog/appender.h>
#import <sys/xattr.h>

@implementation YMSLogUtil

+ (void)initXlogWithPath:(NSString *)logPath attrName:(NSString *)attrName fileNamePre:(NSString *)namePre encodePsw:(NSString *)psw {
    
    NSString *logPathStr = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@",logPath]];
   
    const char* attrNameStr = [attrName UTF8String]; //需要修改
    u_int8_t attrValue = 1;
    setxattr([logPathStr UTF8String], attrNameStr, &attrValue, sizeof(attrValue), 0, 0);
    
#if DEBUG
    xlogger_SetLevel(kLevelDebug);
    appender_set_console_log(true);
#else
    xlogger_SetLevel(kLevelInfo);
    appender_set_console_log(false);
#endif
    appender_open(kAppednerAsync, [logPathStr UTF8String], [namePre UTF8String], [psw length] > 0 ? [psw UTF8String] : "");
}

/// 关闭日志，在applicationWillTerminate实现
+ (void)closeYMSLog {
    appender_close();
}

/// 立即同步日志到文件中
+ (void)syncYMSLog {
    appender_flush_sync();
}

@end
