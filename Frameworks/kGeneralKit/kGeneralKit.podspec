#
# Be sure to run `pod lib lint kGeneralKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#配置本地私有库pod库

Pod::Spec.new do |s|
  s.name             = 'kGeneralKit'
  s.version          = '0.1.0'
  s.summary          = '通用工具库kGeneralKit'
  s.description      = <<-DESC
 通用工具库kGeneralKit.
                       DESC

  s.homepage     = "http://EXAMPLE/kGeneralKit" #不用修改用生成的就行
  s.license          = "MIT"
  s.author           = { 'Dxc123' => 'daixingchuang@163.com' }
  s.source       = { :path => '.' } #本地的写法
  
  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'
  s.source_files = 'src/**/*'
  # s.resources = 'assets/**/*'
  
  # s.resource_bundles = {
  #   'kGeneralKit' => ['kGeneralKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
