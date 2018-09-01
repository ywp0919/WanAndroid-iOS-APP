//
//  HttpUtils.swift
//  WanAndroid-iOS-App
//
//  Created by WeponYan on 2018/8/27.
//  Copyright © 2018年 WeponYan. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class HttpUtils {

    class func requestData(saveCookie : Bool = false, urlString : String , type : MethodType , params : [String : Any]? = nil ,
                           callBack : @escaping (_ result : Any?) -> ()){
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // cookie 设置
        let cookie = (UIApplication.shared.delegate as? AppDelegate)?.cookie
        let headers: HTTPHeaders = [
            "Cookie": cookie == nil ? "" : cookie!
        ]


        Alamofire.request(urlString, method: method, parameters: params ,encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            // 1.校验是否有结果

//             if let result = response.result.value {
//                callBack(result)
//             } else  {
//                print(response.result.error)
//             }
 
            // 1.校验是否有结果
            guard let result = response.result.value else {
                callBack(nil)
                print("请求失败\(response.result.error)")
                return
            }
            
            if(saveCookie){
                // 保存cookie
                // 取出cookie
                let responseCookie = response.response?.allHeaderFields["Set-Cookie"] as? String
                if(responseCookie?.contains("loginUserName") == true){
                    // 二次确认是否有账号信息。
                    print("返回的cookie:\(responseCookie)")
                    (UIApplication.shared.delegate as? AppDelegate)?.cookie = responseCookie
                    UserDefaults.standard.set(responseCookie, forKey: UserDefault_AppCookie)
                }
                
            }
            
            // 2.将结果回调出去
            callBack(result)
            print("请求成功")
        }
        
    };
}
