Pod::Spec.new do |s|
  s.name         = 'SKTUtils'
  s.version      = '0.1'
  s.summary      = 'Utils for Sprite Kit'
  s.author = {
    'http://www.raywenderlich.com/' => 'http://www.raywenderlich.com/'
  }
  s.source = {
    :git => 'https://github.com/happyjiahan/SKTUtils.git',
    :tag => 'happyjiahanV0.1'
  }
  s.homepage    = 'http://www.raywenderlich.com/'
  s.license     = 'LICENSE'
  s.source_files = '*.{h,m}'
  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
end
