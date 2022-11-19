//
//  main.m
//  YMSLog
//
//  Created by suwenxiao on 09/20/2022.
//  Copyright (c) 2022 suwenxiao. All rights reserved.
//

@import UIKit;
#import "YMSAppDelegate.h"
#import "YMSLogUtil.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        [YMSLogUtil initXlogWithPath:@"log" attrName:@"com.best.YMSLog" fileNamePre:@"YMSLog" encodePsw:@""];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([YMSAppDelegate class]));
    }
}
