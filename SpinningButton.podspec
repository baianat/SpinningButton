#
# Be sure to run `pod lib lint SpinningButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpinningButton'
  s.version          = '0.1.0'
  s.summary          = 'A custom UIButton with spinner for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'SpinningButton is a custom button that can easily be transformed into a spinner'
                       DESC

  s.homepage         = 'https://github.com/baianat/SpinningButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'development@baianat.com' => 'development@baianat.com' }
  s.source           = { :git => 'https://github.com/baianat/SpinningButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'SpinningButton/Classes/**/*'
  s.swift_version = '5.0'

end
