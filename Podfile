# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'SwiftProject' do
  #  use dynamic frameworks
  use_frameworks!
  # ignore all warnings from all dependencies
  inhibit_all_warnings!

  # Pods for SwiftProject
#++++网络
    pod 'Alamofire’#网络请求
    pod 'Alamofire-SwiftyJSON'
    pod 'Moya'
    pod 'ReachabilitySwift' #检查网络
    
#++++JSON数据模型转换
    pod 'HandyJSON’
    pod 'SwiftyJSON'
    pod 'KakaJSON'
    
#++++
    pod 'SnapKit'#代码布局
    pod 'Kingfisher'#网络图片缓存库
    pod 'SDWebImage'
    pod 'PKHUD' #swift版Hud
    pod 'MBProgressHUD'
    pod 'SVProgressHUD'
    pod 'MJRefresh'
    pod 'AutoInch','~> 1.3.2'#等比例/全尺寸适配工具
    pod 'BMPlayer'#视频播放
    pod 'NVActivityIndicatorView'#多种菊花
#++++缓存
    pod 'KeychainSwift'
    pod 'KeychainAccess'
    pod 'WCDB.swift'#数据库
#    pod 'SwiftyUserDefaults'#优雅的使用UserDefaults
    pod 'Cache', '~> 6.0.0'
#    pod 'KTVHTTPCache'


#+++++Kit库
     pod 'R.swift'
     pod 'RxSwift'
     pod 'RxCocoa'
     pod 'YYKit','~> 1.0.9'
   
#+++++UI组件库
   pod 'Toast-Swift' #弹窗 tost
   #pod 'IQKeyboardManagerSwift'
    pod 'EmptyDataSet-Swift'
    pod 'Then'#swift初始化库
    pod 'Reusable'#重用视图(UITableViewCells, UICollectionViewCells等）
    pod 'ParallaxHeader', '~> 3.0.0'#添加视差头到UIScrollView/UITableView
    #    pod 'ESTabBarController-swift' # 自定义tabbar样式
    pod 'JXPhotoBrowser','~> 3.1.2'#图片与视频浏览器
#    pod 'KKPhotoBrowser'#Swift轻量级的图片浏览器
    pod 'FSPagerView' # banner滚动图片
#    pod 'DNSPageView' # 分页
#    pod 'PageMenu'# 分页
#    pod 'DropDown'#下拉列表
#    pod 'swiftScan'#二维码 各种码识别，生成，界面效果
#    pod 'DKImagePickerController' # 照片选取
#    pod 'Permission'#统一管理iOS系统的许可，比如相机、相片、定位等。
  pod 'JXSegmentedView'
  pod 'BetterSegmentedControl', '~> 2.0'
  
  
  #+++++扩展库
    pod 'SwifterSwift'  #Swift extensions （最强扩展库）
    pod 'SwiftDate' # Date
    pod 'TSVoiceConverter', '~> 0.1.6'#音频格式转换
#++++封装NSAttributedString
    pod 'BonMot'
    pod 'TextAttributes'#链式结构
    pod 'SwiftyAttributes'#链式结构 封装NSAttributedString
  
    #动画库
#    pod 'EasyAnimation'# 主要UIView.animate动画

#  pod 'kCommonKit'
#  pod 'SwiftExtenions'

  pod 'LookinServer', :configurations => ['Debug']
  pod 'SwiftLint', '= 0.42.0', configurations: ['Debug']
  pod 'SwiftGen', '= 6.4.0', configurations: ['Debug']
 
  #引用内部依赖库(path来指定该内部库的路径)
  pod 'DesignKit', :path => './Frameworks/DesignKit', :inhibit_warnings => false
  pod 'kGeneralKit', :path => './Frameworks/kGeneralKit', :inhibit_warnings => false
  pod 'kExtenionsKit', :path => './Frameworks/kExtenionsKit', :inhibit_warnings => false
  
  
  target 'SwiftProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftProjectUITests' do
    # Pods for testing
  end

end
