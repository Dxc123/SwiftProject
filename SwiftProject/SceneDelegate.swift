//
//  SceneDelegate.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = CJKTTabBarController()
            window.backgroundColor = .white
            self.window = window
            window.makeKeyAndVisible()
            //        每次启动 APP 都获取一次当前系统配置的 bundle
            if UserDefaults.standard.bool(forKey: kIsSetLanguage) {
                kLog("设置过语言")//取设置过的语言
               if let userLanguage = UserDefaults.standard.value(forKey: kUserLanguage) as? String   {
                   LocalizationManger.shareManger.setUserLanguage(language: userLanguage)
               }
            }else{//
                 kLog("未设置过语言")//直接获取手机系统语言
                APPConfig.getSystemLanguage()
            }
            
//            if !UserDefaults.standard.bool(forKey: "FirstLaunchKey") {
//                kLog("第一次进入")
//                UserDefaults.standard.set(true, forKey: "FirstLaunchKey")
//                let window = UIWindow(windowScene: windowScene)
//                window.rootViewController = kLoginViewController()
//                window.backgroundColor = .white
//                self.window = window
//                window.makeKeyAndVisible()
//            } else {
                kLog("再次进入")
                window.rootViewController = CJKTTabBarController()
                window.backgroundColor = .white
                self.window = window
                window.makeKeyAndVisible()
//            }
            
        }
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

