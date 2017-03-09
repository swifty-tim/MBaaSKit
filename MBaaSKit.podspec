#
# Be sure to run `pod lib lint MBaaSKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MBaaSKit'
  s.version          = '0.2.8.3'
  s.summary          = 'MBaaSKit is a framework for connecting to MBaaSKit Sever.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This framework provides tools to handle sending and retrieving objects from the MBaaSKit Server
                       DESC

  s.homepage         = 'https://github.com/collegboi/MBaaSKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'collegboi' => 'timothy.barnard@mydit.ie' }
  s.source           = { :git => 'https://github.com/collegboi/MBaaSKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MBaaSKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MBaaSKit' => ['MBaaSKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
