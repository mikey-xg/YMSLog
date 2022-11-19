//
//  YMSLogUtil.h
//  Pods-YMSLog_Example
//
//  Created by wenxiao su on 2022/10/21.
//

#import <Foundation/Foundation.h>
#import "YMSLogHelper.h"

#define __FILENAME__ (strrchr(__FILE__,'/')+1)

#define YMS_INFO "通用"
#define YMSLOG_INFO(format, ...) LogInternal(kYMSLevelInfo, YMS_INFO, __FILENAME__, __LINE__, __FUNCTION__, @"Info:", format, ##__VA_ARGS__)

NS_ASSUME_NONNULL_BEGIN

@interface YMSLogUtil : NSObject

/// 初始化xlog服务，建议在main文件中初始化
/// @param logPath 日志文件存放目录，NSDocumentDirectory的下一级目录名称
/// @param attrName 属性名称，一般和应用boundleid保持一致
/// @param namePre 日志文件名称前缀，完整名称为"前缀_年月日"
/// @param psw 日志文件加密密码，默认为空
+ (void)initXlogWithPath:(NSString *)logPath attrName:(NSString *)attrName fileNamePre:(NSString *)namePre encodePsw:(NSString *)psw;

/// 关闭日志，在applicationWillTerminate实现
+ (void)closeYMSLog;

/// 立即同步日志到文件中
+ (void)syncYMSLog;

@end

NS_ASSUME_NONNULL_END
