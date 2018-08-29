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

    class func requestData(urlString : String , type : MethodType , params : [String : Any]? = nil ,
                           callBack : @escaping (_ result : Any?) -> ()){
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: params).responseJSON { (response) in
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
            
            // 2.将结果回调出去
            callBack(result)
            print("请求成功")
        }
        
    };
}
