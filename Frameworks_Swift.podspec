#
# Be sure to run `pod lib lint Frameworks_Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Frameworks_Swift'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Frameworks_Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A frameworks for swift, which based on RxSwift.
                       DESC

  s.homepage         = 'https://github.com/lhp3851/Frameworks_Swift'
  s.screenshots      = 'https://blog.ibireme.com/wp-content/uploads/2015/12/IMG_2604_.jpg'
  s.license          = {
      :type => 'MIT',
      :file => 'LICENSE'
  }
  s.author           = { 'lhp3851' => 'lhp3851@163.com' }
  s.source           = {
      :git => 'https://github.com/lhp3851/Frameworks_Swift.git',
      :tag => s.version.to_s,
      :submodules => true
  }
  s.social_media_url = 'https://github.com/lhp3851'
  #s.prefix_header_contents = '#import <UIKit/UIKit.h>'

  s.ios.deployment_target = '10.0'
  s.swift_versions = ['4.0', '4.2', '5.0']

  # s.public_header_files = 'Pod/Classes/**/*.h'

  s.subspec 'Core' do |core|
    core.dependency 'RxSwift', '~> 6.2.0'
    core.dependency 'RxCocoa', '~> 6.2.0'
    core.source_files = 'Frameworks_Swift/Classes/Core/**/*'
  end

  s.subspec 'Components' do |components|
    components.dependency 'Frameworks_Swift/Core'
    components.dependency 'SnapKit', '~> 5.0.1'
    components.source_files = 'Frameworks_Swift/Classes/Components/**/*'
    s.resource_bundles = {
     'Components' => ['Frameworks_Swift/Assets/Components/*.png']
    }
  end

  s.subspec 'NetWork' do |network|
    network.dependency 'Frameworks_Swift/Core'
    network.dependency 'Alamofire', '~> 5.4.3'
    network.source_files = 'Frameworks_Swift/Classes/NetWork/**/*'
  end

  s.subspec 'Image' do |image|
    image.dependency 'Frameworks_Swift/Core'
    image.dependency 'Kingfisher', '~> 6.3.1'
    image.source_files = 'Frameworks_Swift/Classes/Image/**/*'
    s.resource_bundles = {
     'Image' => ['Frameworks_Swift/Assets/Image/*.png']
    }
  end

  s.subspec 'Debug' do |debug|
    debug.dependency 'SwiftLint', '~> 0.44.0'
    debug.dependency 'DoraemonKit', '~> 3.1.0'
    debug.source_files = 'Frameworks_Swift/Classes/Debug/**/*'
  end

  s.subspec 'Profile' do |profile|
    profile.dependency 'matrix-wechat', '~> 1.0.1'
    profile.source_files = 'Frameworks_Swift/Classes/Profile/**/*'
  end

  s.frameworks = 'UIKit', 'Foundation'

end
