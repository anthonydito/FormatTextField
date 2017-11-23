#
# Be sure to run `pod lib lint FormatTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FormatTextField'
  s.version          = '0.1.1'
  s.summary          = 'A convenience class for UITextField that formats and validates input.'

  s.description      = <<-DESC
FormatTextField is a UITextField subclass that formats and validates the input
for the input of a given user. The available options are no format, formatting
as a phone number, formatting currency, and validating email.
                       DESC

  s.homepage         = 'https://github.com/anthonydito/FormatTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anthony Dito' => 'anthonymdito@gmail.com' }
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
