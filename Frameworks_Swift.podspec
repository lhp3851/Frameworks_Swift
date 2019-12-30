#
# Be sure to run `pod lib lint Frameworks_Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Frameworks_Swift'
  s.version          = '0.0.2'
  s.summary          = 'A short description of Frameworks_Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lhp3851/Frameworks_Swift'
  s.screenshots      = 'https://blog.ibireme.com/wp-content/uploads/2015/12/IMG_2604_.jpg'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lhp3851' => 'lhp3851@163.com' }
  s.source           = { :git => 'https://github.com/lhp3851/Frameworks_Swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/lhp3851'
  #s.prefix_header_contents = '#import <UIKit/UIKit.h>'

  s.ios.deployment_target = '10.0'
  s.swift_versions = ['4.0', '4.2', '5.0']

  s.source_files = 'Frameworks_Swift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Frameworks_Swift' => ['Frameworks_Swift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'Alamofire'
  s.dependency 'SnapKit'
  s.dependency 'Kingfisher'
  s.dependency 'RxSwift', '~> 5'
  s.dependency 'RxCocoa', '~> 5'
  s.dependency 'matrix-wechat'
  s.dependency 'SwiftLint'
  s.dependency 'DoraemonKit','~> 2.0.0'
end
