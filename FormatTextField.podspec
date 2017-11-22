#
# Be sure to run `pod lib lint FormatTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FormatTextField'
  s.version          = '0.1.0'
  s.summary          = 'A convenience class for UITextField that formats the input.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here. This description will have to be a little longer to make sure that I talk about all the different options available.
                       DESC

  s.homepage         = 'https://github.com/anthonydito/FormatTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anthony Dito' => 'anthony.dito@walla.by' }
  s.source           = { :git => 'https://github.com/anthonydito/FormatTextField.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FormatTextField/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FormatTextField' => ['FormatTextField/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
