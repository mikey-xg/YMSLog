#
# Be sure to run `pod lib lint YMSLog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YMSLog'
  s.version          = '0.1.0'
  s.summary          = '日志工具'
  s.description      = "高性能日志工具"
  s.homepage         = 'https://github.com/suwenxiao/YMSLog'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'suwenxiao' => 'suwenxiao@tal.com' }
  s.source           = { :git => 'https://github.com/suwenxiao/YMSLog.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  
  s.vendored_frameworks = "YMSLog/Classes/libs/mars.framework"
  s.source_files  = "YMSLog/Classes/*.{h,m,mm}"
  s.public_header_files = "YMSLog/Classes/*.h"
  s.frameworks = "SystemConfiguration","CoreTelephony","Foundation"
  s.libraries = "z","c++"
  
  s.pod_target_xcconfig = {
    'VALID_ARCHS[sdk=iphonesimulator*]' => '',
    'DEFINES_MODULE' => 'YES',
    'ENABLE_BITCODE' => 'NO',
  }
  
end
