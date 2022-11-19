//
//  YMSLogUpload.h
//  YMSLog
//
//  Created by 苏文潇 on 2022/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FinishBlock)(NSString *zipFilePath);

@interface YMSLogUpload : NSObject

- (void)uploadLogFinish:(FinishBlock)finish;

+ (void)removeUploadZipFile;

@end

NS_ASSUME_NONNULL_END
