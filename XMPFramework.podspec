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
  s.version          = '0.0.1'
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
  s.source_files = 'XMPFramework/Classes/**/*', 'XMPFramework/Adobe-XMP-ToolKit/include/**/*'
  s.vendored_libraries = 'XMPFramework/Adobe-XMP-ToolKit/libraries/libXMPCoreStatic.a', 'XMPFramework/Adobe-XMP-ToolKit/libraries/libXMPFilesStatic.a'
  s.module_name = 'XMPFramework'
  s.pod_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'IOS_ENV=1' }
  s.libraries = 'resolv', 'stdc++'
  s.ios.deployment_target = '8.0'
  s.pod_target_xcconfig = { 'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/XMPFramework/XMPFramework/Adobe-XMP-ToolKit/include $(SRCROOT)/../../XMPFramework/XMPFramework/Adobe-XMP-ToolKit/include $(SRCROOT)/../../XMPFramework/Adobe-XMP-ToolKit/include',
                            'VALID_ARCHS' => 'armv7 x86_64 arm64' }
  
end
