//
//  kAuthorizeUtils.swift
//  kGeneralKit
//
//  Created by daixingchuang on 2021/6/25.
//权限管理类

import UIKit
import UIKit
import AVFoundation
import Photos
import AssetsLibrary
class kAuthorizeUtils: NSObject {
    //MARK: ----获取相册权限
    public func authorizePhotoWith(comletion:@escaping (Bool)->Void )
    {
        let granted = PHPhotoLibrary.authorizationStatus()
        switch granted {
        case PHAuthorizationStatus.authorized:
            comletion(true)
        case PHAuthorizationStatus.denied,PHAuthorizationStatus.restricted:
            comletion(false)
        case PHAuthorizationStatus.notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                comletion(status == PHAuthorizationStatus.authorized ? true:false)
            })
         default:
            break
        }
        
    }
    
    //MARK: ---相机权限
    public func authorizeCameraWith(comletion:@escaping (Bool)->Void )
    {
        let granted = AVCaptureDevice.authorizationStatus(for: AVMediaType.video);
        
        switch granted {
        case AVAuthorizationStatus.authorized:
            comletion(true)
            break;
        case AVAuthorizationStatus.denied:
            comletion(false)
            break;
        case AVAuthorizationStatus.restricted:
            comletion(false)
            break;
        case AVAuthorizationStatus.notDetermined:
            
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted:Bool) in
                comletion(granted)
            })
        default:
            break
        }
    }
    
    //MARK:跳转到APP系统设置权限界面
    public func jumpToSystemPrivacySetting()
    {
        let appSetting = URL(string:UIApplication.openSettingsURLString)
        
        if appSetting != nil
        {
            if #available(iOS 10, *) {
                UIApplication.shared.open(appSetting!, options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.openURL(appSetting!)
            }
        }
    }
    
}
