//
//  AppDelegate.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/26.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 保存一个全局的cookie,每次运行从磁盘中加载一次放在内存中读取更快。
    public var cookie: String?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 取出保存的cookie
        cookie = UserDefaults.standard.string(forKey: UserDefault_AppCookie)
        
        print("取到的cookie：\(String(describing: cookie))")
//        if(cookie == nil){
//            cookie = "JSESSIONID=2FC8573F9E3E179D9C8031D215025224; Path=/; HttpOnly,loginUserName=weponYan; Expires=Fri, 28-Sep-2018 07:52:55 GMT; Path=/,loginUserPassword=12345678; Expires=Fri, 28-Sep-2018 07:52:55 GMT; Path=/,token_pass=08937b953a34ae42f65e461149b23129; Expires=Fri, 28-Sep-2018 07:52:55 GMT; Path=/"
//            print("自动设置了一个cookie：\(cookie)")
//        }
        
        window = UIWindow.init(frame: UIScreen.main.bounds);
        let rootVC = MainViewController();
        let rootNVC = UINavigationController.init(rootViewController: rootVC)
        
        window?.rootViewController = rootNVC;
        window?.backgroundColor = UIColor.white;
        window?.makeKeyAndVisible();
        
        
    
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

