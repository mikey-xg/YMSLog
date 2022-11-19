# YMSLog

[![CI Status](https://img.shields.io/travis/suwenxiao/YMSLog.svg?style=flat)](https://travis-ci.org/suwenxiao/YMSLog)
[![Version](https://img.shields.io/cocoapods/v/YMSLog.svg?style=flat)](https://cocoapods.org/pods/YMSLog)
[![License](https://img.shields.io/cocoapods/l/YMSLog.svg?style=flat)](https://cocoapods.org/pods/YMSLog)
[![Platform](https://img.shields.io/cocoapods/p/YMSLog.svg?style=flat)](https://cocoapods.org/pods/YMSLog)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YMSLog is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YMSLog'
```

## YMSLog 日志解析文档

```
// 下载 python 2.7.18版本
// 使用 python 2.7.18 内的pip 安装 zstandard
// 解析脚本

// 例如： 
// 第一步python2.7 安装 zstandard 包
$ /Users/xxx/.pyenv/versions/2.7.18/bin/pip install zstandard

// 第二步骤：使用脚本解析.xlog加密文件
// 其中：decode_mars_nocrypt_log_file.py 为无加密解析脚本文件
//      YMSLog_20220921.xlog 为待解析的本地日志文件
$ /Users/xxx/.pyenv/versions/2.7.18/bin/python2.7 decode_mars_nocrypt_log_file.py YMSLog_20220921.xlog

备注：
/Users/xxx/.pyenv/versions/2.7.18/bin/ 是我python2.7的安装路径
为了方便 你可以配置一个环境变量。在 .base_profile或者 .zshrc 中便于调用
当然，你也可以不设置，用法就如上使用

```

## Author

suwenxiao, suwenxiao@tal.com

## License

YMSLog is available under the MIT license. See the LICENSE file for more info.
