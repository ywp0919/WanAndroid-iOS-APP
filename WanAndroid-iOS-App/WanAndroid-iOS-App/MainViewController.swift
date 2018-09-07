//
//  ViewController.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/26.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        createTabs();
        
        // 这样设置就有效果了。 但是看到源码注释的意思是针对整个TabBar的设置的  - -!
        UITabBar.appearance().tintColor = COLOR_TEXT_GREEN
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal),  style: .done, target: self, action: #selector(clickSearch))
//            UIBarButtonItem.init(title: "搜索", style: .done, target: self, action: #selector(clickSearch))
        
       
        
        //        UITabBarItem.appearance().setTitleTextAttributes(NSDictionary(), for:UIControlState.normal);
        
        // 不知道为什么这种方法没有效果。
        //        self.tabBarController?.tabBar.tintColor = UIColor.green;
        //        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.gray;
    }

    
    // 去搜索页面
    @objc func clickSearch(){
        self.navigationController?.pushViewController(SearchArcticleViewController(), animated: true)
    }
    
    // 创建 tabs
    func createTabs(){
        // 主页 Tab VC
        let homeVC = HomeVC();
        homeVC.tabBarItem = UITabBarItem(title: "主页", image: #imageLiteral(resourceName: "icon_bottom_main_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "icon_bottom_main_checked").withRenderingMode(UIImageRenderingMode.alwaysOriginal));
        
        let homeNVC = UINavigationController(rootViewController: homeVC);
        //        homeNVC.navigationItem.title = "主页";
        
        
        // 知识体系
        let knowledgeVC = KnowledgeVC();
        knowledgeVC.tabBarItem = UITabBarItem(title: "知识体系", image: #imageLiteral(resourceName: "icon_bottom_knowledge_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "icon_bottom_knowledge_checked").withRenderingMode(UIImageRenderingMode.alwaysOriginal));
        let knowledgeNVC = UINavigationController(rootViewController: knowledgeVC);
        
        // 热门
        let hotVC = HotVC();
        hotVC.tabBarItem = UITabBarItem(title: "热门",image:
            #imageLiteral(resourceName: "icon_bottom_hot_nor").withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage:
            #imageLiteral(resourceName: "icon_bottom_hot_checked").withRenderingMode(UIImageRenderingMode.alwaysOriginal));
        let hotNVC = UINavigationController(rootViewController: hotVC);
        
        // 我的
        let myVC = MyVC()
        myVC.tabBarItem = UITabBarItem(title: "我的", image:
            #imageLiteral(resourceName: "icon_bottom_my_nor").withRenderingMode(.alwaysOriginal), selectedImage:
            #imageLiteral(resourceName: "icon_bottom_my_checked").withRenderingMode(.alwaysOriginal))
        let myNVC = UINavigationController(rootViewController: myVC)
        
        
//        self.viewControllers = [homeNVC, knowledgeNVC, hotNVC, myNVC];
        
        self.viewControllers = [homeVC, knowledgeVC, hotVC, myVC];
    }
    

    
    
    
}

