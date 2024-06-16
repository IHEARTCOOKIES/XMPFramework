#
# Be sure to run `pod lib lint XMPFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  
  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name             = 'XMPFramework'
  s.version          = '1.0.0'
  s.summary          = 'Simple XMP framework to read/write XMP data.'
  s.description      = 'XMPFramework is a simple Objective-C wrapper on top of Adobe XMP ToolKit that allow for a native API similar to NSUserDefaults to read/write XMP data.'

  # ―――  Author/License data  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.homepage         = 'https://github.com/IHEARTCOOKIES/XMPFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Filip Busic' => 'filipbusic12@gmail.com' }
  s.source           = { :git => 'https://github.com/IHEARTCOOKIES/XMPFramework.git', :tag => s.version.to_s }

  # ―――  Source data  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.public_header_files = 'XMPFramework/Classes/Public/**/*.h'
  s.private_header_files = 'XMPFramework/Classes/Private/**/*.h'
  s.prefix_header_file = 'XMPFramework/Classes/Include/XMPFramework-PrefixHeader.pch'
  s.source_files = 'XMPFramework/Classes/**/*'
  s.vendored_frameworks = 'XMPFramework/Adobe-XMP-ToolKit/libXMPCoreStatic.xcframework', 'XMPFramework/Adobe-XMP-ToolKit/libXMPFilesStatic.xcframework'
  s.module_name = 'XMPFramework'
  s.libraries = 'resolv'
  s.ios.deployment_target = '12.0'
  s.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) COCOAPODS=1 IOS_ENV=1 XMP_iOSBuild=1 XMP_StaticBuild=1',
      'CLANG_CXX_LIBRARY' => 'libc++'
  }
  
end
