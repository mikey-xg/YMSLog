//
//  YMSLogUpload.m
//  YMSLog
//
//  Created by 苏文潇 on 2022/11/19.
//

#import "YMSLogUpload.h"
#import "ZipArchive.h"
#import "YMSLogUtil.h"

#define YMSLOGNAME @"YMS_logs.zip"

@interface YMSLogUpload()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation YMSLogUpload

- (void)uploadLogFinish:(FinishBlock)finish {
    
    [YMSLogUtil syncYMSLog];
    NSString *rootDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *tempFolderPath = [NSString stringWithFormat:@"%@/zipTempFolder",rootDocPath];
    NSString *zipFilePath = [NSString stringWithFormat:@"%@/%@",rootDocPath, YMSLOGNAME];
    
    [self createTempZipFolderFromPath:tempFolderPath];
    [self copyLogFilesFromDocFolder:rootDocPath toTempFolder:tempFolderPath];
    [self createZipFileFrom:tempFolderPath toPath:zipFilePath];
    [self cleanTempFolderWithPath:tempFolderPath];
}

/// 创建临时文件夹用于存放需要压缩上传的日志文件
/// @param tempFolderPath 临时文件夹目录地址
- (void)createTempZipFolderFromPath:(NSString *)tempFolderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:tempFolderPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:tempFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

/// 将项目的日志文件拷贝到临时目录
/// @param docFolderPath 沙盒doc目录路径
/// @param tempFolderPath 临时目录路径
- (void)copyLogFilesFromDocFolder:(NSString *)docFolderPath toTempFolder:(NSString *)tempFolderPath {
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    NSString *projLogPath = [NSString stringWithFormat:@"%@/log",docFolderPath];
    NSArray *projDirArray = [fileManger contentsOfDirectoryAtPath:projLogPath error:nil];
    
    // 最近3天日志
    NSString *todayDateStr = [self getDateStrWithDayPlus:0];
    NSString *yesterdayDateStr = [self getDateStrWithDayPlus:-1];
    NSString *supYesterdayDateStr = [self getDateStrWithDayPlus:-2];
    
    for (NSString *strPath in projDirArray) {
        if ([strPath containsString:todayDateStr] || [strPath containsString:yesterdayDateStr] || [strPath containsString:supYesterdayDateStr]) {
            NSString *fromPath = [NSString stringWithFormat:@"%@/%@",projLogPath,strPath];
            NSString *toPath = [NSString stringWithFormat:@"%@/%@",tempFolderPath,strPath];
            BOOL copyResult = [fileManger copyItemAtPath:fromPath toPath:toPath error:nil];
            NSLog(@"logInfo: log file copy:%@",copyResult ? @"yes" : @"no");
        }
    }
}


- (void)createZipFileFrom:(NSString *)tempFolderPath toPath:(NSString *)zipFilePath {
    // 判断文件是否存在，存在则先删除
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:zipFilePath];
    if (existed) {
        [fileManager removeItemAtPath:zipFilePath error:nil];
    }
    
    BOOL zipCreateResult = [SSZipArchive createZipFileAtPath:zipFilePath withContentsOfDirectory:tempFolderPath];
    NSLog(@"logInfo: log zip file create:%@",zipCreateResult ? @"yes" : @"no");
}

- (void)cleanTempFolderWithPath:(NSString *)tempFolderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:tempFolderPath isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) ) {
        return;
    }
    //文件夹
    BOOL tempFolderRemoveResult = [fileManager removeItemAtPath:tempFolderPath error:nil];
    NSLog(@"logInfo: log temp folder remove:%@",tempFolderRemoveResult ? @"yes" : @"no");
}

+ (void)removeUploadZipFile {
    NSString *rootDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *zipFilePath = [NSString stringWithFormat:@"%@/%@",rootDocPath, YMSLOGNAME];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:zipFilePath]) {
        NSError *err;
        if ([fileManager removeItemAtPath:zipFilePath error:&err]) {
            NSLog(@"logInfo: log zipfile remove success");
        } else {
            NSLog(@"logInfo: log zipfile remove fail");
        }
    } else {
        NSLog(@"file is not exit");
    }
}

- (NSString *)getDateStrWithDayPlus:(NSInteger)dayPlus {
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *handleComps = [[NSDateComponents alloc] init];
    [handleComps setDay:dayPlus];
    NSDate *newdate = [calendar dateByAddingComponents:handleComps toDate:currentDate options:0];
    NSString *dateTime = [self.dateFormatter stringFromDate:newdate];
    
    return dateTime;
}


- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyyMMdd";
    }
    
    return _dateFormatter;
}

@end
