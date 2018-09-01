//
//  LoginOrRegisterVC.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/29.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit

// 登录 或者 注册
class LoginOrRegisterVC: UIViewController {

    @IBOutlet weak var inputAccount: UITextField!
    @IBOutlet weak var inputPsw: UITextField!
    
    // 登录
    @IBAction func login(_ sender: Any) {
        let account = inputAccount.text
        let psw = inputPsw.text
        

        
        if(account?.count ?? 0 >= 8 && (psw?.count ?? 0 >= 8)){
            
            let params = ["username": account!,
                          "password": psw!]
            
            HttpUtils.requestData(saveCookie: true, urlString: "http://www.wanandroid.com/user/login", type: .post, params:params, callBack: {(value) in
                if(value == nil){
                    self.view.makeToast("请求数据失败")
                    return
                }
                
                let dictionary = value as! [String : AnyObject]
                if((dictionary["errorCode"] as! Int) == 0){
                    // 登录成功
                    print("登录成功")
                    // 发出登录成功的通知吧
                    NotificationCenter.default.post(name: .init(Noti_Login_In), object: nil)
                    self.navigationController?.popViewController(animated: true)

                }else {
                    self.view.makeToast(dictionary["errorMsg"] as? String)
                }
                
            
            })
        }else{
            self.view.makeToast("请输入8位长度及以上的账号与密码")
        }
    }
    
    // 注册
    @IBAction func register(_ sender: Any) {
        let account = inputAccount.text
        let psw = inputPsw.text
        if(account?.count ?? 0 >= 8 && (psw?.count ?? 0 >= 8)){
            
        }else{
            self.view.makeToast("请输入8位长度及以上的账号与密码")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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
