Pod::Spec.new do |s|
  s.name             = 'PopupAlertController'
  s.version          = '1.0.0'
  s.summary          = 'A popup alert view controller for iOS.'
  s.homepage         = 'https://github.com/Bushtit/PopupAlertController'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Bushtit Lab' => 'admin@meniny.cn' }
  s.source           = { :git => 'https://github.com/Bushtit/PopupAlertController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/Bushtit/PopupAlertController'

  s.swift_version    = '4.1'
  s.ios.deployment_target = '9.0'
  s.source_files = 'PopupAlertController/Classes/**/*'

  s.dependency 'DynamicBlurView', '~> 2.0'
end
