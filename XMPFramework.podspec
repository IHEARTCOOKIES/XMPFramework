#
# Be sure to run `pod lib lint XMPFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XMPFramework'
  s.version          = '1.0.0'
  s.summary          = 'A short description of XMPFramework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/IHEARTCOOKIES/XMPFramework'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Filip Busic' => 'filipbusic12@gmail.com' }
  s.source           = { :git => 'https://github.com/Filip Busic/XMPFramework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'


  s.source_files = 'XMPFramework/Classes/**/*', 'XMPFramework/Adobe-XMP-ToolKit/include/**/*'
  
  
  s.vendored_libraries = 'XMPFramework/Adobe-XMP-ToolKit/libraries/libXMPCoreStatic.a', 'XMPFramework/Adobe-XMP-ToolKit/libraries/libXMPFilesStatic.a'
  
  
  # Keep in mind that the directory may not have the files in it... So.. Think about the best way to fix this problem.
  s.xcconfig = { 'USER_HEADER_SEARCH_PATHS' => '/Users/filipbusic/Desktop/XMPFramework/XMPFramework/Adobe-XMP-ToolKit/include/**' }

  s.public_header_files = 'XMPFramework/Classes/Public/**/*.h'
  s.private_header_files = 'XMPFramework/Classes/Private/**/*.h', 'XMPFramework/Adobe-XMP-ToolKit/include/**/*'
  
  s.module_name = 'XMPFramework'
  
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
