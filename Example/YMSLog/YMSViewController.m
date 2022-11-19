//
//  YMSViewController.m
//  YMSLog
//
//  Created by suwenxiao on 09/20/2022.
//  Copyright (c) 2022 suwenxiao. All rights reserved.
//

#import "YMSViewController.h"
#import "YMSLogUpload.h"

@interface YMSViewController ()

@end

@implementation YMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for (int i = 0; i < 100; i++) {
        YMSLOG_INFO(@"你好....%@", @(i));
    }
    
    
//    [self performSelector:@selector(push) withObject:nil afterDelay:2.0];
}
- (IBAction)uploadClick:(UIButton *)sender {
    NSLog(@"点击了上传按钮");
    [self push];
}

- (IBAction)removeClick:(UIButton *)sender {
    NSLog(@"点击了删除当前压缩文件");
    [YMSLogUpload removeUploadZipFile];
}

- (void)push {
    YMSLogUpload *l = [YMSLogUpload new];
    
    [l uploadLogFinish:^(NSString * _Nonnull zipFilePath) {
        NSLog(@"zipFilePath = %@", zipFilePath);
        NSLog(@"开始上传, 走上传逻辑");
    }];
    
}

@end
