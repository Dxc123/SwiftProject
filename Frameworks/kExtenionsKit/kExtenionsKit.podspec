#
# Be sure to run `pod lib lint kExtenionsKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#配置本地私有库pod库

Pod::Spec.new do |s|
  s.name             = 'kExtenionsKit'
  s.version          = '0.1.0'
  s.summary          = '设计通用库DesignKit.'
  s.description      = <<-DESC
  设计通用库DesignKit.
                       DESC

  s.homepage     = "http://EXAMPLE/kExtenionsKit" #不用修改用生成的就行
  s.license          = "MIT"
  s.author           = { 'Dxc123' => 'daixingchuang@163.com' }
  s.source       = { :path => '.' } #本地的写法
  
  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'
  s.source_files = 'src/**/*'
  # s.resources = 'assets/**/*'
  
  # s.resource_bundles = {
  #   'kExtenionsKit' => ['kExtenionsKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
