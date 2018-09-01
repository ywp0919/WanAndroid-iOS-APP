//
//  MyVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/29.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

class MyVC: UIViewController {

    
    @IBOutlet weak var buttonLikeArticle: UIButton!
    @IBOutlet weak var imageHead: UIImageView!
    
    @IBOutlet weak var labelLoginStatus: UILabel!
    
    @IBOutlet weak var buttonLogin: UIButton!
    // 去登录页面
    @IBAction func goLoginPage(_ sender: Any) {
        
        if((UIApplication.shared.delegate  as? AppDelegate)?.cookie == nil){
            // 如果没有登录，就去登录页面
            navigationController?.pushViewController(LoginOrRegisterVC(), animated: true)
        }else {
            // 如果登录了，就是退出登录
            //            showLoginOutDialog()
            loginOut()
        }
        
    }
    
    // 去我喜欢的文章页面
    @IBAction func goLikeArticlePage(_ sender: Any) {
        if((UIApplication.shared.delegate  as? AppDelegate)?.cookie == nil){
            // 如果没有登录，就去登录页面
            navigationController?.pushViewController(LoginOrRegisterVC(), animated: true)
        }else {
            navigationController?.pushViewController(MyCollectArticleVC(), animated: true)
        }
    }
    // 显示一个退出的提示框
    func showLoginOutDialog() {

    }
    

    override func viewDidAppear(_ animated: Bool) {
        
        self.parent?.navigationItem.title = "我的"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        
        if((UIApplication.shared.delegate as? AppDelegate)?.cookie == nil){
            loginOut()
        }else{
            loginIn()
        }
        
        
        // 通知接收器
        NotificationCenter.default.addObserver(self, selector: #selector(loginIn), name: NSNotification.Name.init(Noti_Login_In), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(loginOut), name: NSNotification.Name.init(Noti_Login_Out), object: nil)
        
    }
    
    
    @objc func loginIn(){
        imageHead.image = #imageLiteral(resourceName: "icon_my_head")
        labelLoginStatus.text = "已登录"
        buttonLogin.setTitle("退出登录", for: .normal)
        
    }
    
    @objc func loginOut(){
        imageHead.image = #imageLiteral(resourceName: "icon_head_default")
        labelLoginStatus.text = "未登录"
        buttonLogin.setTitle("前往登录", for: .normal)
        // 清除cookie数据
        (UIApplication.shared.delegate as? AppDelegate)?.cookie = nil
        UserDefaults.standard.set(nil, forKey: UserDefault_AppCookie)
        // 发出通知
        NotificationCenter.default.post(name: NSNotification.Name.init(Noti_Login_Out), object: nil)
    }
    
    
    // 释放掉监听
    deinit {
        NotificationCenter.default.removeObserver(self)
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

