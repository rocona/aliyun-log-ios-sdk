################################################################################################################################
##################################################### podspec file for dev #####################################################
################################################################################################################################

Pod::Spec.new do |s|
  s.name             = 'AliyunLogProducer'
  s.version          = '3.1.7.beta.1'
  s.summary          = 'aliyun log service ios producer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
log service ios producer.
https://help.aliyun.com/document_detail/29063.html
https://help.aliyun.com/product/28958.html
                       DESC

  s.homepage         = 'https://github.com/aliyun/aliyun-log-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aliyun-log' => 'yulong.gyl@alibaba-inc.com' }
  s.source           = { :git => 'https://github.com/aliyun/aliyun-log-ios-sdk.git', :tag => s.version.to_s }
  s.social_media_url = 'http://t.cn/AiRpol8C'

  # s.ios.deployment_target = '10.0'
  # s.osx.deployment_target =  '10.12'
  # s.tvos.deployment_target =  '10.0'
  s.platform     = :ios, "10.0"

  s.requires_arc  = true
  s.libraries = 'z'
  s.swift_version = "5.0"
#  s.xcconfig = { 'GCC_ENABLE_CPP_EXCEPTIONS' => 'YES' }

  s.default_subspec = 'Producer'
  
  s.subspec 'Producer' do |c|
    c.ios.deployment_target = '10.0'
    c.tvos.deployment_target =  '10.0'
    c.osx.deployment_target =  '10.12'
    c.source_files = 'Sources/Producer/**/*.{h,m}', 'Sources/aliyun-log-c-sdk/**/*.{c,h}'
    c.public_header_files =
      'Sources/Producer/inclue/*.h',
      'Sources/aliyun-log-c-sdk/src/log_define.h',
      'Sources/aliyun-log-c-sdk/src/log_http_interface.h',
      'Sources/aliyun-log-c-sdk/src/log_inner_include.h',
      'Sources/aliyun-log-c-sdk/src/log_multi_thread.h',
      'Sources/aliyun-log-c-sdk/src/log_producer_client.h',
      'Sources/aliyun-log-c-sdk/src/log_producer_common.h',
      'Sources/aliyun-log-c-sdk/src/log_producer_config.h'
  end

  s.subspec 'Core' do |c|
    c.ios.deployment_target = '10.0'
    c.tvos.deployment_target =  '10.0'
    c.osx.deployment_target =  '10.12'
    c.dependency 'AliyunLogProducer/Producer'
    c.dependency 'AliyunLogProducer/OT'
    c.source_files = 'Sources/Core/**/*.{m,h}'
    c.public_header_files = 'Sources/Core/include/*.h'
  end
  
  s.subspec 'OTSwift' do |o|
    o.ios.deployment_target = '10.0'
    o.tvos.deployment_target =  '10.0'
    o.osx.deployment_target =  '10.12'
    o.source_files = 'Sources/OTSwift/**/*.{m,h,swift}'
  end
  
  s.subspec 'OT' do |o|
    o.ios.deployment_target = '10.0'
    o.tvos.deployment_target =  '10.0'
    o.osx.deployment_target =  '10.12'
    o.source_files = 'Sources/OT/**/*.{m,h}'
    o.public_header_files = 'Sources/OT/**/include/*.h'
    
    o.dependency 'AliyunLogProducer/OTSwift'
  end
  
  s.subspec 'CrashReporter' do |c|
    c.ios.deployment_target = '10.0'
    c.tvos.deployment_target =  '10.0'
    c.osx.deployment_target =  '10.12'
    c.dependency 'AliyunLogProducer/Core'
    c.dependency 'AliyunLogProducer/OT'
    c.dependency 'AliyunLogProducer/Trace'
    c.source_files = 'Sources/CrashReporter/**/*.{m,h}'
    c.public_header_files = 'Sources/CrashReporter/include/*.h'
    c.vendored_frameworks = 'Sources/WPKMobi/WPKMobi.xcframework'
    c.exclude_files = 'Sources/WPKMobi/WPKMobi.xcframework/**/Headers/*.h'

    c.ios.frameworks = "SystemConfiguration", "CoreGraphics"
    c.tvos.frameworks = "SystemConfiguration", "CoreGraphics"
    c.osx.frameworks = "SystemConfiguration", "Cocoa"
    
    c.ios.libraries = "z", "c++"
    c.tvos.libraries = "z", "c++"
    c.osx.libraries = "z", "c++"

    c.ios.pod_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
        'OTHER_LDFLAGS' => '-ObjC'
    }
    c.ios.user_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }

    c.tvos.pod_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'arm64',
        'OTHER_LDFLAGS' => '-ObjC'
    }
    c.tvos.user_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=appletvsimulator*]' => 'arm64'
    }

    c.osx.pod_target_xcconfig = {
       'OTHER_LDFLAGS' => '-ObjC'
    }
  end
  
  s.subspec 'NetworkDiagnosis' do |n|
    n.dependency 'AliyunLogProducer/Core'
    n.dependency 'AliyunLogProducer/OT'
    n.source_files = 'Sources/NetworkDiagnosis/**/*.{m,h}'
    n.public_header_files = "Sources/NetworkDiagnosis/include/*.h"
    n.vendored_frameworks = 'Sources/AliNetworkDiagnosis/AliNetworkDiagnosis.xcframework'
    n.exclude_files = 'Sources/AliNetworkDiagnosis/AliNetworkDiagnosis.xcframework/**/Headers/*.h'
    n.frameworks = "SystemConfiguration", "CoreGraphics"
    n.libraries = "z", "c++", "resolv"
    n.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
      'OTHER_LDFLAGS' => '-ObjC',
    }
    n.user_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
  end
  
  s.subspec 'Trace' do |t|
    t.ios.deployment_target = '10.0'
    t.tvos.deployment_target =  '10.0'
    t.osx.deployment_target =  '10.12'
    t.dependency 'AliyunLogProducer/Producer'
    t.dependency 'AliyunLogProducer/Core'
    t.dependency 'AliyunLogProducer/OT'
    t.source_files = 'Sources/Trace/**/*.{m,h}'
    t.public_header_files = "Sources/Trace/include/*.h"
    t.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
      'OTHER_LDFLAGS' => '-ObjC',
    }
    t.user_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
  end
  
  s.subspec 'URLSessionInstrumentation' do |t|
    t.ios.deployment_target = '10.0'
    t.tvos.deployment_target =  '10.0'
    t.osx.deployment_target =  '10.12'
#    t.dependency 'AliyunLogProducer/Producer'
#    t.dependency 'AliyunLogProducer/Core'
    t.dependency 'AliyunLogProducer/OT'
    t.dependency 'AliyunLogProducer/Trace'
    t.source_files = 'Sources/Instrumentation/URLSession/**/*.{m,h,swift}'
#    t.public_header_files = "Trace/**/*.h"
    t.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
      'OTHER_LDFLAGS' => '-ObjC',
    }
    t.user_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
  end
end

