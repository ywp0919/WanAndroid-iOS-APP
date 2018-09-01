//
//  MyWebViewVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/29.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit
import WebKit

// 我的webview显示 页面
class MyWebViewVC: UIViewController {
    
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = title ?? "网页"
        
        // 可以修改返回键的样式
        // self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back", style: .plain, target: nil, action: nil)
        
        
        // 添加 webview

        let webView = WKWebView.init(frame: view.frame)
        if(url != nil){
            webView.load(URLRequest.init(url: URL.init(string: url!)!))
        }
        
        self.view.addSubview(webView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

